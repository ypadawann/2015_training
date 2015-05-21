
require 'grape'

require './model/users'

module API
  module V1
    class APIUsers < Grape::API
      resource :users do
        params do
          requires :id, type: Integer, desc: '社員番号'
          requires :name, type: String, desc: 'ユーザ名'
          requires :department, type: Integer, desc: '部署名'
          requires :password, type: String, desc: 'パスワード'
        end
        post do
          if Users.add(params[:id], params[:name],
                       params[:department], params[:password])
            { user_id:    params[:id],
              name:       params[:name],
              department: params[:department] }
          else
            error!('ユーザの登録に失敗しました。', 400)
          end
        end

        params do
          requires :id, type: Integer, desc: '社員番号'
        end
        route_param :id do
          get do
            Users.status(params[:id]) || error!('403 Forbidden', 403)
          end
        end
      end
    end
  end
end
