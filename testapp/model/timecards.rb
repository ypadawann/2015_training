# -*- coding: utf-8 -*-

require 'active_support'

require_relative '_entity/database_information'

module Model
  class Timecard_operation
    def self.prepare_timecard(day, user_id)
      Model::Timecard.where(day: day, user_id: user_id).first ||
      Model::Timecard.new(day: day, user_id: user_id)
    end

    def self.attend(day, user_id, time)
      timecard = prepare_timecard(day, user_id)
      if timecard.attendance.present?
        false
      else
        timecard.attendance = time
        timecard.save
      end
    end

    def self.update_attend(date, user_id, time)
      timecard = Timecard.where(day: date, user_id: user_id).first
      if timecard.nil?
        new_timecard_add(user_id, date, time, nil)
      else
        timecard.attendance = time
        timecard.save
      end
    end

    def self.returnhome(day, user_id, time)
      timecard = prepare_timecard(day, user_id)
      if timecard.leaving.present?
        false
      else
        timecard.leaving = time
        timecard.save
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

    def self.update_all(year, month, timecard_data, user_id)
      timecard_data.each do |tc_data|
        date = "#{year}-#{month}-#{tc_data[1].day}"
        timecard = prepare_timecard(date, user_id)
        timecard.attendance = tc_data[1].attendance
        timecard.leaving = tc_data[1].leaving
        timecard.save
      end
    end

    def self.push_empty_data(t, day_from, day_to)
      day_from.upto(day_to) do |d|
        t.push(day: d, attendance: '', leaving: '')
      end
    end

    def self.read_monthly_data(user_id, year, month)
      timecards = Model::Timecard.where('day LIKE ?', "#{year}-#{month}-%")
                  .where(user_id: user_id).order('day')
      i = 1
      timecard_json = []
      timecards.each do |t|
        push_empty_data(timecard_json, i, t.day.day - 1)
        timecard_json.push(day: i, attendance: t.attendance, leaving: t.leaving)
        i = t.day.day + 1
      end
      max_day = (Date.new(year.to_i, month.to_i + 1) - 1).day
      push_empty_data(timecard_json, i, max_day)
      timecard_json
    end

    def self.get_attendance(day, user_id)
      Model::Timecard.where(day: day, user_id: user_id).first
        .try(:attendance)
    end

    def self.get_leaving(day, user_id)
      Model::Timecard.where(day: day, user_id: user_id).first
        .try(:leaving)
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
      if time.nil?
        return ''
      else
        return time
      end
    end
  end
end
