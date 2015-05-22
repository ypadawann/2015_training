
module API
  module V1
    module Utils
      def authenticate!(user_id)
        if user_id == env['rack.session'][:no].to_i
          env['rack.session'][:no] = user_id
        else
          error!('Access Denied', 403)
        end
      end
    end
  end
end
