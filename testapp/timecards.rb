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

  def self.read_monthly_data(user_id, year, month)
    # dayカラムから年月の前方一致検索してから、user_idで完全一致検索
    #timecards = (Timecard.where("day LIKE ?", "#{year}-#{month}-%").where(:user_id => user_id)).all
    max_day = (Date::new(year.to_i,month.to_i+1)-1).day
    timecard_json = []
    for i in 1..max_day do
      day = Date::new(year.to_i,month.to_i,i)
      timecard_db = Timecard.where(:day => day, :user_id => user_id).first
      p timecard_db
      timecard = 
        if timecard_db == nil
          t = {:attendance => nil, :leaving => nil}
        else
          attendance = time_to_string(timecard_db.attendance)
          leaving = time_to_string(timecard_db.leaving)
          t = {:attendance => attendance, :leaving => leaving}
        end
      timecard_json.push(timecard)
    end
    return timecard_json.to_json
  end


  def self.time_to_string(time)
    p 'time'
    p time
    if time == nil
      return nil
    else
      return time.strftime("%X")
    end
  end


end

