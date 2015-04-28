# -*- coding: utf-8 -*-

require_relative 'database_information'

class UsersAccessError < RuntimeError; end

class Timecard_operation

  def self.attend(date,no,time)
    timecards = Timecard.new
    timecards.no = no
    timecards.day = date
    # timecards.attendance = time
    timecards.attendance = time
    begin
      timecards.save
    rescue
      return false
    end
    return true
  end

  def self.returnhome(day,no,time)
    timecards = Timecard.where(:day => day,:no => no).first
    if timecards==nil # まだ出勤していない
      return 'no attend'
    elsif timecards.leaving==nil #退勤処理
      timecards.leaving = time
      timecards.save
      return 'leave'
    else #退勤済み
      return 'already leave'
    end
  end

  def self.read_monthly_data(no,month)
    # dayカラムから'2015-04'で前方一致検索してから、no=123で完全一致検索
    timecards = Timecard.where("day LIKE ?", "#{month}-%").where(:no => no)
#    p timecards.all[0].attendance.to_s
    return timecards.all
  end

end

