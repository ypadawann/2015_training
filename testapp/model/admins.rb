# -*- coding: utf-8 -*-

require 'digest/sha2'
require 'securerandom'
require 'active_support/all'

require_relative '_entity/database_information'

module Model
  class Admins
    class <<self
      public

      def verify(name, password)
        admin = Model::Admin.find_by(admin_name: name)
        admin && Model::Helper.start_verify(admin.password, password)
      end

      def add(name, password)
        admin =
          Model::Admin.new(
            admin_name: name,
            password: Model::Helper.start_hash(password)
          )
        admin.save
      end

      def remove(name)
        Model::Admin.destroy(name)
        true
      rescue ActiveRecord::RecordNotFound,
             ActiveRecord::StatementInvalid
        false
      end

      def update_password(name, password)
        admin = Model::Admin.find_by(admin_name: name)
        admin.password = Model::Helper.start_hash(password)
        admin.save
      end

    end
  end
end
