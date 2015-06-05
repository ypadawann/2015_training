module API
  module V1
    module AdminUtlis     
      def session_check()
        if !env['rack.session'][:admi_login]
          error!('Not Found', 404)
        end
      end
    end
  end
end
