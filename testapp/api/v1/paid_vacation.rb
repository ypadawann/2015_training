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
          paid_vacation_num = Model::Users.get_usable_vacation_num(user_id)
          { paid_vacation_num: paid_vacation_num }
        end

        desc '有給取得日一括登録'
        post do
        end

      end
    end
  end
end
