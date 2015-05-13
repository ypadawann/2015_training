# -*- coding: utf-8 -*-

require 'active_support'

require_relative '_entity/database_information'

class UsersAccessError < RuntimeError; end

class Timecard_operation
  def self.attend(day, user_id, time)
    timecards = Timecard.where(day: day, user_id: user_id).first
    if timecards.nil?
      timecards = Timecard.new
      timecards.user_id = user_id
      timecards.day = day
      timecards.attendance = time
      timecards.save
      return "#{day}は#{time}に出勤しました"
    else
      return '本日はすでに出勤しています'
    end
  end

  def self.returnhome(day, user_id, time)
    timecards = Timecard.where(day: day, user_id: user_id).first
    if timecards.nil?
      return '本日はまだ出勤していません'
    elsif timecards.leaving.nil?
      timecards.leaving = time
      p timecards
      timecards.save
      return "#{day}は#{time}に退勤しました"
    else
      return '本日はすでに退勤しています'
    end
  end

  def self.read_monthly_data(user_id, year, month)
    timecards = Timecard.where('day LIKE ?', "#{year}-#{month}-%")
                .where(user_id: user_id).order('day')
    empty_data = { attendance: '', leaving: '' }
    i = 1
    timecard_json = []
    timecards.each do |t|
      i.upto(t.day.day - 1) do
        timecard_json.push(empty_data)
      end
      attendance = time_to_string(t.attendance)
      leaving = time_to_string(t.leaving)
      timecard_json.push(attendance: attendance, leaving: leaving)
      i = t.day.day + 1
    end
    max_day = (Date.new(year.to_i, month.to_i + 1) - 1).day
    i.upto(max_day) do
      timecard_json.push(empty_data)
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
