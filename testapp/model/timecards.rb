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
      timecard.attendance = time
      timecard.save
    end

    def self.returnhome(day, user_id, time)
      timecard = prepare_timecard(day, user_id)
      timecard.leaving = time
      timecard.save
    end

    def self.update_all(year, month, timecard_data, user_id)
      timecard_data.each do |tc_data|
        p tc_data
        date = sprintf("%d-%02d-%02d", year, month, tc_data[1].day)
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
      timecards =
        Model::Timecard.where('day LIKE ?', sprintf("%d-%02d-%", year, month))
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

    def self.get_used_vacation_num(user_id, year)
      timecard =
        Timecard.where(user_id: user_id).where(day: "#{year}-04-01".."#{year+1}-03-30")
      use_paid_vacation = 0
      timecard.each do |t|
        use_paid_vacation += t.paid_vacation unless t.paid_vacation.nil?
      end
      return use_paid_vacation
    end

    def self.add_paid_vacation(user_id, full_dates, half_dates)
      full_dates.length.times do |i|
        timecard = prepare_timecard(full_dates[i].date, user_id)
        timecard.paid_vacation = 1
        timecard.save
      end

      half_dates.length.times do |i|
        timecard = prepare_timecard(half_dates[i].date, user_id)
        timecard.paid_vacation = 0.5
        timecard.save
      end
    end
    
  end
end
