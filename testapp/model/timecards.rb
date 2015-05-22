# -*- coding: utf-8 -*-

require 'active_support'

require_relative '_entity/database_information'

module Model
  class Timecard_operation
    def self.attend(day, user_id, time)
      timecards = Model::Timecard.where(day: day, user_id: user_id).first
      if timecards.nil?
        new_timecard_add(user_id, day, time, nil)
#        return "#{day}は#{time}に出勤しました"
        return true
      else
#        return '本日はすでに出勤しています'
        return false
      end
    end

    def self.update_attend(date, user_id, time)
      p 'update attend'
      timecard = Timecard.where(day: date, user_id: user_id).first
      if timecard.nil?
        p 'new'
        new_timecard_add(user_id, date, time, nil)
      else
        p 'update'
        timecard.attendance = time
        timecard.save
      end
    end
    
    def self.returnhome(day, user_id, time)
      timecards = Model::Timecard.where(day: day, user_id: user_id).first
      if timecards.nil?
      #  return '本日はまだ出勤していません'
        return false
      elsif timecards.leaving.nil?
        timecards.leaving = time
        timecards.save
        #return "#{day}は#{time}に退勤しました"
        return true
      else
#        return '本日はすでに退勤しています'
        return false
      end
    end

    def self.update_leave(date, user_id, time)
      timecard = Timecard.where(day: date, user_id: user_id).first
      if timecard.nil?
        new_timecard_add(user_id, date, nil, time)
      else
        timecard.leaving = time
        timecard.save
      end
    end

    def self.update_all(year_month, timecard_data, user_id)
      timecard_data.each do |tc_data|
        date = year_month + '-' + tc_data[1].day
        timecard = Timecard.where(day: date, user_id: user_id).first
        if timecard.nil?
          new_timecard_add(user_id, date, tc_data[1].attendance, tc_data[1].leaving)
        else
          timecard.attendance = tc_data[1].attendance
          timecard.leaving = tc_data[1].leaving
          timecard.save
        end
      end
    end
    
    def self.read_monthly_data(user_id, year, month)
      timecards = Model::Timecard.where('day LIKE ?', "#{year}-#{month}-%")
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

    def self.new_timecard_add(user_id, day, attendance, leaving)
      timecards = Model::Timecard.new
      timecards.user_id = user_id
      timecards.day = day
      timecards.attendance = attendance
      timecards.leaving = leaving
      timecards.save
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
end
