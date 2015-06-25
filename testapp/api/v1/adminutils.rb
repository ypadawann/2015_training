# -*- coding: utf-8 -*-
module API
  module V1
    module AdminUtlis     
      def session_check()
        if !env['rack.session'][:admin_login]
          error!('セッション認証に失敗しました', 403)
        end
      end

      def check_activerecord_validation(error_msg)
        if !error_msg.empty?
          error_msg.each_value{ |value|
            error!(value, 400)
          }
        end
      end
    end
  end
end
