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
          if !env['rack.session'][:login_status]
            error!('Not Found', 404)
          end
        end  
      end

      resource '/admin' do
        desc '管理者登録'
        params do
          requires :admin_id, type: Integer , desc: '管理者ID'
          requires :admin_password, type: String, desc: 'パスワード'
          requires :admin_name, type: String, desc: '管理者名'
        end
        post do
          if Model::Admins.add(params[:admin_id], 
                              params[:admin_name], params[:admin_password])
          else
            error!('Failed to Register', 400)
          end
        end
      end

      resource '/admin/logout' do
        desc 'ログアウト'
        put  do
          p 'logout'
          env['rack.session'].destroy
        end
      end

      resource '/admin/login' do
        desc 'ログイン'
        params do
          requires :admin_id, type: Integer, desc: '管理者ID' 
          requires :admin_password, type: String, desc: 'パスワード'
        end
        put  do
          p params[:admin_id]
          p params[:admin_password]
          verify_password!(params[:admin_id], params[:admin_password])
          env['rack.session'][:id] = params[:admin_id]
          env['rack.session'][:login_status] = true
        end
      end
      
      
      resource '/admin/:admin_id' do
        desc '管理者削除'
        params do
          requires :admin_id, type: Integer , desc: '管理者ID'
        end
        delete do
        end

        desc '管理者情報更新'                
        params do
          requires :admin_name, type: String, desc: '管理者名'
          requires :admin_new_password, type: String, desc: '新しいパスワード'
          requires :admin_password, type: String, desc: 'パスワード' 
        end
        put do
        end
      end
      
      resource '/admin/users/:user_id' do
        params do
          requires :user_id, type: Integer, desc: '社員番号'
        end
        
        desc 'ユーザ情報の取得' 
        get do
          session_check()
          p 'get users'
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
          optional :user_name, type: String, desc: 'ユーザ名'
          optional :department, type: String, desc: '部署名'
          optional :new_password, type: String, desc: '新しいパスワード'
        end
        put do
          session_check()
          user_id = params[:user_id]
#          authenticate!(user_id)
#          verify_password!(user_id, params[:password])
          
          if params[:name].present?
            Model::Users.update_name(user_id, params[:name]) \
          end
          if params[:department].present?
            Model::Users.update_department(user_id, params[:department])
          end
          if params[:new_password].present?
            Model::Users.update_password(user_id, params[:new_password]) \
          end   
          Model::Users.status(user_id)
        end
      end
    end
  end
end
      
