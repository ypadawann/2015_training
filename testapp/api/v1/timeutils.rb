# -*- coding: utf-8 -*-

require 'holiday_jp'

class Float
  def rounddown_point5
    (self * 2.0).floor / 2.0
  end
end

module API
  module V1
    module TimeUtils
      MIDNIGHT_START = 22.0
      MIDNIGHT_END   = 24.0 + 5.0
      BREAKTIME = 1.0
      TIME_DELIMITER = ':'
      WEEKDAY_NAMES = %w(日 月 火 水 木 金 土)

      public

      def get_full_attendance_data(user_id, year, month)
        timecards =
          Model::Timecard_operation.read_monthly_data(user_id, year, month)
        timecards.map do |timecard|
          timecard
            .merge!(types_of_day(year, month, timecard[:day]))
            .merge!(calculate_extra_hours(timecard))
        end
      end

      def calculate_totals(data)
        { midnight_work: attr_total(data, :midnight_work),
          holiday_shift: attr_total(data, :holiday_shift),
          paid_vacation: attr_total(data, :paid_vacation),
          hours_worked: attr_total(data, :hours_worked),
          days_worked: data.count{|d| d[:hours_worked] && d[:hours_worked] > 0.0 }
        }
      end

      private

      def types_of_day(year, month, day)
        date = Date.new(year, month, day)
        { weekday: WEEKDAY_NAMES[date.wday],
          isholiday: HolidayJp.holiday?(date) || isweekend(date.wday) }
      end

      def calculate_extra_hours(timecard)
        if timecard[:attendance].blank? || timecard[:leaving].blank?
          { midnight_work: nil,
            holiday_shift: nil,
            hours_worked: nil
          }
        else
          hour_from = convert_to_hours(timecard[:attendance])
          hour_to   = convert_to_hours(timecard[:leaving])
          diff = hour_to - hour_from
          { midnight_work: midnight_work(hour_from, hour_to),
            holiday_shift:
              holiday_shift(timecard[:isholiday], hour_from, hour_to),
            hours_worked: diff >= 6.0 ? (diff - BREAKTIME) : diff
          }
        end
      end

      def attr_total(data, attr)
        data.inject(0.to_f) { |total, d|
          total + (d[attr].presence || 0)
        }.rounddown_point5
      end

      def isweekend(wday)
        wday == 0 || wday == 6
      end

      def convert_to_hours(time)
        hour, minute = time.split(TIME_DELIMITER)
        hour.to_i + (minute.to_i / 15) * 0.25
      end

      def midnight_work(hour_from, hour_to)
        hours = hour_to - hour_from

        hours_before_midnight = MIDNIGHT_START - hour_from
        hours -= hours_before_midnight if hours_before_midnight > 0

        hours_after_midnight = hour_to - MIDNIGHT_END
        hours -= hours_after_midnight if hours_after_midnight > 0

        hours > 0 ? hours : 0
      end

      def holiday_shift(isholiday, hour_from, hour_to)
        if isholiday
          diff = hour_to - hour_from
          diff >= 6.0 ? (diff - BREAKTIME) : diff
        else
          nil
        end
      end
    end
  end
end
