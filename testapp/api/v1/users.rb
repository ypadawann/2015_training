
require './model/users'

module API
  module V1
    class Users < Grape::API
      resource :users do
        desc 'ユーザ一覧の取得'
        get do
          Model::Users.list_all.to_json(except: :password)
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

        params do
          requires :user_id, type: Integer, desc: '社員番号'
        end
        route_param :user_id do
          desc 'ユーザ情報の取得'
          get do
            authenticate!(params[:user_id])
            Model::Users.status(params[:user_id])
          end
          desc 'ユーザ削除'
          delete do
            authenticate!(params[:user_id])
            Model::Users.remove(params[:user_id]) ||
              error!('Not Found', 404)
          end
        end
      end
    end
  end
end
