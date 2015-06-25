# -*- coding: utf-8 -*-
module API
  module V1
    module AdminUtlis     
      def session_check()
        if !env['rack.session'][:admin_login]
          error!('セッション認証に失敗しました', 403)
        end
      end
    end
  end
end
