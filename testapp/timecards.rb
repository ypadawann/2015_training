# -*- coding: utf-8 -*-

require_relative 'database_information'

class UsersAccessError < RuntimeError; end

class Timecard_operation

  def self.attend(day,user_id,time)
    timecards = Timecard.where(:day => day,:user_id => user_id).first
    if timecards == nil
      timecards = Timecard.new
      timecards.user_id = user_id
      timecards.day = day
      timecards.attendance = time
      timecards.save
      return "#{day}は#{time}に出勤しました"
    else
      return "本日はすでに出勤しています"
    end
  end

  def self.returnhome(day,user_id,time)
    timecards = Timecard.where(:day => day,:user_id => user_id).first
    if timecards==nil # まだ出勤していない
      return '本日はまだ出勤していません'
    elsif timecards.leaving==nil #退勤処理
      timecards.leaving = time
      p timecards
      timecards.save
      return "#{day}は#{time}に退勤しました"
    else #退勤済み
      return '本日はすでに退勤しています'
    end
  end

  def self.read_monthly_data(user_id,month)
    # dayカラムから'2015-04'で前方一致検索してから、user_id=123で完全一致検索
    timecards = Timecard.where("day LIKE ?", "#{month}-%").where(:user_id => user_id)
#    p timecards.all[0].attendance.to_s
    return timecards.all
  end

end

