# -*- coding: utf-8 -*-

require './model/users'

module API
  module V1
    class Users < Grape::API
      helpers do
        def verify_password!(user_id, password)
          error!('Access Denied', 403) unless
            Model::Users.verify(user_id, password)
        end

        def find_user!(user_id)
          error!('Not Found', 404) unless
            Model::Users.exists?(user_id)
        end
      end

      resource '/users' do
        desc 'ユーザ一覧の取得'
        get do
          { users: Model::Users.list_all }
        end

        desc '新規ユーザ登録'
        params do
          requires :user_id, type: Integer, desc: '社員番号'
          requires :name, type: String, desc: 'ユーザ名'
          requires :department, type: String, desc: '部署名'
          requires :password, type: String, desc: 'パスワード'
        end
        post do
          if Model::Users.add(params[:user_id], params[:name],
                              params[:department], params[:password])
            { user_id:    params[:user_id],
              name:       params[:name],
              department: params[:department] }
          else
            error!('Failed to Register', 400)
          end
        end
      end

      params do
        requires :user_id, type: Integer, desc: '社員番号'
      end
      resource '/users/:user_id' do
        desc 'ユーザ情報の取得'
        get do
          authenticate!(params[:user_id])
          find_user!(params[:user_id])
          Model::Users.status(params[:user_id])
        end

        desc 'ユーザ削除'
        delete do
          authenticate!(params[:user_id])
          find_user!(params[:user_id])
          Model::Users.remove(params[:user_id])
          Model::Users.status(params[:user_id])
        end

        desc 'ユーザ情報の変更'
        params do
          optional :name, type: String, desc: 'ユーザ名'
          optional :department, type: String, desc: '部署名'
          optional :new_password, type: String, desc: '新しいパスワード'
          requires :password, type: String, desc: '現在のパスワード'
        end
        put do
          user_id = params[:user_id]
          authenticate!(user_id)
          verify_password!(user_id, params[:password])

          Model::Users.update_name(user_id, params[:name]) \
            if params[:name].present?
          Model::Users.update_department(user_id, params[:department]) \
            if params[:department].present?
          Model::Users.update_password(user_id, params[:new_password]) \
            if params[:new_password].present?

          Model::Users.status(user_id)
        end

        desc 'ログイン'
        params do
          requires :password, type: String, desc: 'パスワード'
        end
        put '/login' do
          verify_password!(params[:user_id], params[:password])
          session_create(params[:user_id])
          Model::Users.status(params[:user_id])
        end

        desc 'ログアウト'
        put '/logout' do
          session_destroy()
          find_user!(params[:user_id])
          Model::Users.status(params[:user_id])
        end
      end
    end
  end
end
