# -*- coding: utf-8 -*-

require './model/users'

module API
  module V1
    class Admin < Grape::API
      helpers do
        def verify_password!(user_id, password)
          error!('Access Denied', 403) unless
            Model::Admins.verify(user_id, password)
        end

        def find_user!(user_id)
          error!('Not Found', 404) unless
            Model::Users.exists?(user_id)
        end

        def session_check()
          if !env['rack.session'][:admin_login_status]
            error!('Not Found', 404)
          end
        end
        
      end

      desc 'ログイン'
      put '/admin/login' do
        params do
          requires :admin_name, type: String, desc: '管理者ID'
          requires :password, type: String, desc: 'パスワード'
        end
        verify_password!(params[:admin_name], params[:password])
        env['rack.session'][:admin_name] = params[:admin_name]
        env['rack.session'][:admin_login_status] = true
        p env['rack.session'][:admin_name]
        p env['rack.session'][:admin_login_status]
      end
      
      desc 'ログアウト'
      put '/admin/logout' do
        p 'logout'
        env['rack.session'].destroy
      end
      

      params do
        requires :user_id, type: Integer, desc: '社員番号'
      end
      resource '/admin/:user_id' do
        desc 'ユーザ情報の取得' 
       get do
          session_check()
          Model::Users.status(params[:user_id])
        end
        
        desc 'ユーザ削除'
        delete do
          session_check()
          find_user!(params[:user_id])
          Model::Users.remove(params[:user_id])
          Model::Users.status(params[:user_id])
        end

        desc 'ユーザ情報の変更'
        params do
          optional :name, type: String, desc: 'ユーザ名'
          optional :department, type: String, desc: '部署名'
          optional :new_password, type: String, desc: '新しいパスワード'
        end
        put do
          session_check
          user_id = params[:user_id]
          Model::Users.update_name(user_id, params[:name]) \
            if params[:name].present?
          Model::Users.update_department(user_id, params[:department]) \
            if params[:department].present?
          Model::Users.update_password(user_id, params[:new_password]) \
            if params[:new_password].present?

          Model::Users.status(user_id)
        end

      end
    end
  end
end
