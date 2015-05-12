# -*- coding: utf-8 -*-

require_relative 'database_information'

class UsersAccessError < RuntimeError; end

class Timecard_operation

  # 出勤時処理
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


  #退勤時処理
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


  # 月の出退勤データを取得
  def self.read_monthly_data(user_id, year, month)
    timecards = (Timecard.where("day LIKE ?", "#{year}-#{month}-%").where(:user_id => user_id)).order("day")
    max_day = (Date::new(year.to_i,month.to_i+1)-1).day
    timecard_json = []
    if timecards.length == 0
      for i in 1..max_day do
        t = { attendance: "", leaving: "" }
        timecard_json.push(t)
      end
    else
      timecards_num = 0
      for day in 1..max_day do
        date = Date::new(year.to_i,month.to_i,day)
        t = 
          if timecards[timecards_num].day == date
            attendance = time_to_string(timecards[timecards_num].attendance)
            leaving = time_to_string(timecards[timecards_num].leaving)
            if timecards_num < timecards.length-1
              timecards_num = timecards_num + 1
            end
            { attendance: attendance, leaving: leaving }
          else
            { attendance: "", leaving: ""}
          end
        timecard_json.push(t)
      end
    end
    return timecard_json.to_json
  end

  
  # time型をstring型に変換
  def self.time_to_string(time)
    p 'time'
    p time
    if time == nil
      return ""
    else
      return time.strftime("%H:%M")
    end
  end


end

