module API
  module V1
    module AdminUtlis     
      def session_check()
        if !env['rack.session'][:admin_login]
          error!('Access Denied(', 403)
        end
      end
    end
  end
end
