# -*- coding: utf-8 -*-

require_relative '_entity/database_information'

class UsersAccessError < RuntimeError; end

class Timecard_operation
  def self.attend(day, user_id, time)
    timecards = Timecard.where(day: day, user_id: user_id).first
    if timecards.nil?
      new_timecard_add(user_id, day, time, nil)
      return "#{day}は#{time}に出勤しました"
    else
      return '本日はすでに出勤しています'
    end
  end

  def self.new_timecard_add(user_id, day, attendance, leaving)
    timecards = Timecard.new
    timecards.user_id = user_id
    timecards.day = day
    timecards.attendance = attendance
    timecards.leaving = leaving
    timecards.save
  end

  def self.returnhome(day, user_id, time)
    timecards = Timecard.where(day: day, user_id: user_id).first
    if timecards.nil?
      return '本日はまだ出勤していません'
    elsif timecards.leaving.nil?
      timecards.leaving = time
      timecards.save
      return "#{day}は#{time}に退勤しました"
    else
      return '本日はすでに退勤しています'
    end
  end

  def self.read_monthly_data(user_id, year, month)
    timecards =
      (Timecard.where('day LIKE ?', "#{year}-#{month}-%")
         .where(user_id: user_id)).order('day')
    max_day = (Date.new(year.to_i, month.to_i + 1) - 1).day
    timecard_json = []
    timecards_num = 0
    for day in 1..max_day do
      date = Date.new(year.to_i, month.to_i, day)
      t =
        if timecards[timecards_num].try(:day) == date
          attendance = time_to_string(timecards[timecards_num].attendance)
          leaving = time_to_string(timecards[timecards_num].leaving)
          timecards_num += 1
          { attendance: attendance, leaving: leaving }
        else
          { attendance: '', leaving: '' }
        end
      timecard_json.push(t)
    end
    timecard_json.to_json
  end

  def self.time_to_string(time)
    p 'time'
    p time
    if time.nil?
      return ''
    else
      return time.strftime('%H:%M')
    end
  end
end
