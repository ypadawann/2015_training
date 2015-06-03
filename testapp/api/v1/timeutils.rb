
require 'holiday_jp'

module API
  module V1
    module TimeUtils
      MIDNIGHT_START = 22.0
      MIDNIGHT_END   = 24.0 + 5.0
      TIME_DELIMITER = ':'
      WEEKDAY_NAMES = %w(日 月 火 水 木 金 土)

      public

      def types_of_day(year, month, day)
        date = Date.new(year, month, day)
        { weekday: WEEKDAY_NAMES[date.wday],
          isholiday: HolidayJp.holiday?(date) || isweekend(date.wday) }
      end

      def calculate_extra_hours(timecard)
        if timecard[:attendance].blank? || timecard[:leaving].blank?
          { midnight_work: nil,
            holiday_shift: nil }
        else
          hour_from = convert_to_hours(timecard[:attendance])
          hour_to   = convert_to_hours(timecard[:leaving])
          { midnight_work: midnight_work(hour_from, hour_to),
            holiday_shift:
              holiday_shift(timecard[:isholiday], hour_from, hour_to) }
        end
      end

      private

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

        hours > 0 ? hours : nil
      end

      def holiday_shift(isholiday, hour_from, hour_to)
        isholiday ? (hour_to - hour_from) : nil
      end
    end
  end
end