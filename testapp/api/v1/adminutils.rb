module API
  module V1
    module AdminUtlis     
      def session_check()
        if !env['rack.session'][:login_status]
          error!('Not Found', 404)
        end
      end
    end
  end
end
