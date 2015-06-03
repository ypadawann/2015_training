# -*- coding: utf-8 -*-
require './model/users'
require './model/timecards'

module API
  module V1
    class PaidVacation < Grape::API
      params do
        requires :user_id, type: Integer, desc: '社員番号'
      end
      before do
        authenticate!(params[:user_id].to_i)
      end
      resource '/users/:user_id/paid-vacation' do
        desc '有給残数取得'
        get do
          user_id = params[:user_id]
          user_enter = Model::Users.get_enter(user_id)
          this_year = get_business_year(Date.today)

          carry_over = 0
          year = user_enter.year
          while year < this_year do
            carry_over =
              calculate_carry_over(user_id, user_enter, year, carry_over)
            year += 1
          end

          given = get_given_vacation_num(year, user_enter)
          used = Model::Timecard_operation.get_used_vacation_num(user_id, year)
          usable_vacation = carry_over + given - used

          { paid_vacation_num: usable_vacation }
        end

      end
    end
  end
end
