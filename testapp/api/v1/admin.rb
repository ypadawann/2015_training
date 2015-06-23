# -*- coding: utf-8 -*-

require './model/users'

module API
  module V1
    class Admin < Grape::API
      helpers do
        def verify_password!(admin_id, admin_password)
          error!('Access Denied', 403) unless
            Model::Admins.verify(admin_id, admin_password)
        end
        
        def find_user!(user_id)
          error!('the account is not found', 404) unless
            Model::Users.exists?(user_id)
        end
        
        def find_admin!(user_id)
          error!('the account is not found', 404) unless
            Model::Admins.exists?(user_id)
        end
      end

      resource '/admin' do
        desc '管理者登録'
        params do
          requires :admin_id, type: String , desc: '管理者ID'
          requires :admin_password, type: String, desc: 'パスワード'
        end
        post do
          session_check()
          if params[:admin_password].length < 8
            error!('Failed to Register', 400)
          end
          if Model::Admins.add(params[:admin_id], params[:admin_password])
          else
            error!('Failed to Register', 400)
          end
        end
      end

      resource '/admin/logout' do
        desc 'ログアウト'
        put  do
          env['rack.session'].destroy
        end
      end

      resource '/admin/login' do
        desc 'ログイン'
        params do
          requires :admin_id, type: String, desc: '管理者ID' 
          requires :admin_password, type: String, desc: 'パスワード'
        end
        put  do
          verify_password!(params[:admin_id], params[:admin_password])
          env['rack.session'][:id] = params[:admin_id]
          env['rack.session'][:admin_login] = true
        end
      end
      
      
      resource '/admin/:admin_id' do
        params do
          requires :admin_id, type: String , desc: '管理者ID'
        end
        desc '管理者削除'
        delete do
          session_check()
          if env['rack.session'][:id] == params[:admin_id]
            error!('Can not delete this account', 400)
          end
          if !Model::Admins.remove(params[:admin_id])
            error!('Fail to Delete', 400)
          end
        end

        desc '管理者情報取得'
        get do
          session_check()
          find_admin!(params[:admin_id])
          Model::Admins.status(params[:admin_id])
        end

        desc '管理者情報更新'                
        params do
          optional :admin_new_password, type: String, desc: '新しいパスワード'
          requires :admin_password, type: String, desc: 'パスワード' 
        end
        put do
          session_check()
          verify_password!(params[:admin_id], params[:admin_password])
          if params[:admin_new_password].present?
            Model::Admins.update_password(
              params[:admin_id], params[:admin_new_password])
          end
        end
      end
      
      resource '/admin/users/:user_id' do
        params do
          requires :user_id, type: Integer, desc: '社員番号'
        end
        
        desc 'ユーザ情報の取得' 
        get do
          session_check()
          find_user!(params[:user_id])
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
          find_user!(user_id)
          
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
      
