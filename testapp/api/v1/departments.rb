
module API
  module V1
    class Departments < Grape::API
      helpers do
        def find!(department_id)
          error!('Not Found', 404) unless
            Departments.exists?(department_id)
        end
      end

      resources '/departments' do
        desc '部署一覧の取得'
        get do
          { departments: Model::Departments.list_all }
        end

        desc '部署の登録'
        params do
          requires :name, type: String, desc: '部署名'
        end
        post do
          if Departments.add(params[:name])
            { department_id: Departments.id_of(params[:name]),
              name: params[:name] }
          else
            error!('Failed to Register', 400)
          end
        end

        params do
          requires :department_id, type: Integer, desc: '部署番号'
        end
        route_param :department_id do
          desc '部署情報の取得'
          get do
            find!(params[:department_id])
            name = Model::Departments.name_of(params[:department_id])
            { department_id: params[:department_id], name: name }
          end

          desc '部署名の変更'
          params do
            requires :name, type: String, desc: '新しい部署名'
          end
          put do
            find!(params[:department_id])
            Departments.update(params[:department_id], params[:name])
            { department_id: params[:department_id], name: params[:name] }
          end

          desc '部署の削除'
          delete do
            find!(params[:department_id])
            name = Model::Departments.name_of(params[:department_id])
            if Departments.remove(params[:department_id])
              { department_id: params[:department_id], name: name }
            else
              error!('Failed to Delete', 400)
            end
          end
        end
      end
    end
  end
end
