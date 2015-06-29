module API
  module V1
    module Utils
      def authenticate!(user_id)
        if env['rack.session'][:user_login]
        else
          'error'
          error!('Access Denied', 403)
        end
      end

      def session_create(user_id)
        env['rack.session'][:user_id] = params[:user_id]
        env['rack.session'][:user_login] = true
      end

      def session_destroy()
        env['rack.session'].destroy
      end

      def calculate_carry_over(user_id, enter, year, carry_over)
        given = get_given_vacation_num(year, enter)
        used = Model::Timecard_operation.get_used_vacation_num(user_id, year)
        if used > carry_over
          carry_over + given - used
        else
          given
        end
      end

      def get_business_year(date)
          if date.month >= 4
            date.year
          else
            date.year - 1
          end
      end

      def is_training?(enter)
        finish_date = enter >> 4
        if finish_date > Date.today
          return true
        else
          return false
        end
      end

      def newly_paid_vacation(enter)
        if is_training?(enter)
          return 1
        end
        return temp =
          case enter.month
          when 4..9
            10
          when 10
            5
          when 11
            4
          when 12
            3
          when 1
            2
          when 2
            1
          when 3
          end
      end

      def get_given_vacation_num(year, enter)
        job_length = year - get_business_year(enter)
        if job_length < 0
          return 0
        end
        return temp =
          case  job_length
          when 0 then
            newly_paid_vacation(enter)
          when 1 then
            11
          when 2 then
            12
          when 3 then
            14
          when 4 then
            16
          when 5 then
            18
          else
            20
          end
      end

    end
  end
end
