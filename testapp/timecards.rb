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
    timecards = (Timecard.where("day LIKE ?", "#{year}-#{month}-%").where(:user_id => user_id)).all
#    p timecards.all[0].attendance.to_s
    
    max_day = (Date::new(year.to_i,month.to_i+1)-1).day

    timecard_json = []

    if timecards.length == 0
      # まだ当月の出退勤データが無いとき
      p "timecards == nil"
      for i in 1..max_day do
        date = Date::new(year.to_i,month.to_i,i)
        t = {:day => date, :user_id => user_id, :attendance => nil, :leaving => nil}
        #timecards.push(t)
        timecard_json.push(t)
      end
    else
      #当月の出退勤データがある
      timecards_num = 0
      for i in 1..max_day do
        date = Date::new(year.to_i,month.to_i,i)
        if timecards[timecards_num].day == date
          timecard_json.push(timecards[timecards_num])
          timecards_num = timecards_num + 1
        else
          t = {:day => date, :user_id => user_id, :attendance => nil, :leaving => nil}
          #timecards.push(t)
          timecard_json.push(t)
        end
      end
    end
    
    #return timecards.to_json
    return timecard_json.to_json
  
  end

end

