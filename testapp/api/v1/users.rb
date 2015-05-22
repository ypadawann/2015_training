
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
          requires :id, type: Integer, desc: '社員番号'
          requires :name, type: String, desc: 'ユーザ名'
          requires :department, type: String, desc: '部署名'
          requires :password, type: String, desc: 'パスワード'
        end
        post do
          if Model::Users.add(params[:id], params[:name],
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
          desc 'ユーザ情報の取得'
          get do
            Model::Users.status(params[:id]) || error!('403 Forbidden', 403)
          end
          desc 'ユーザ削除'
          delete do
            Model::Users.remove(params[:id])
          end
        end
      end
    end
  end
end