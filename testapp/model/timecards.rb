# -*- coding: utf-8 -*-

require 'active_support'
require 'action_controller'

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

    def self.permitted_update_params(params)
      ActionController::Parameters.new(params).permit(
        :attendance, :leaving,
        :midnight_work, :holiday_shift, :paid_vacation,
        :prearranged_holiday, :holiday_acquisition, :etc
      )
    end

    def self.find_invalid_data(year, month, timecard_data, user_id)
      timecard_data.each do |tc_data|
        date = sprintf("%d-%02d-%02d", year, month, tc_data.day)
        params = permitted_update_params(tc_data)
        timecard = Model::Timecard.new(day: date, user_id: user_id)
        timecard.attributes = params
        if timecard.invalid?
          return [timecard.day, timecard.errors.messages.values.join("\n")]
        end
      end
      nil
    end

    def self.update_all(year, month, timecard_data, user_id)
      timecard_data.each do |tc_data|
        date = sprintf("%d-%02d-%02d", year, month, tc_data.day)
        timecard = prepare_timecard(date, user_id)
        params = permitted_update_params(tc_data)
        timecard.update_attributes(params)
      end
    end

    def self.empty_data(day_from, day_to)
      (day_from..day_to).map do |d|
        { day:                   d,
          attendance:          nil,
          leaving:             nil,
          prearranged_holiday: nil,
          paid_vacation:       nil,
          holiday_acquisition: nil,
          etc:                 nil  }
      end
    end

    def self.read_monthly_data(user_id, year, month)
      timecards =
        Model::Timecard.where('day LIKE ?', sprintf("%d-%02d-%", year, month))
        .where(user_id: user_id).order('day')
      day = 1
      timecards.map do |t|
        previous_day = day
        day = t.day.day + 1
        stored_data = { day:                 t.day.day,
                        attendance:          t.attendance,
                        leaving:             t.leaving,
                        prearranged_holiday: t.prearranged_holiday,
                        paid_vacation:       t.paid_vacation,
                        holiday_acquisition: t.holiday_acquisition,
                        etc:                 t.etc                  }
        empty_data(previous_day, t.day.day - 1) << stored_data
      end
        .concat(empty_data(day, Date.new(year, month, -1).day))
        .flatten(1)
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
