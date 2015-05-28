# -*- coding: utf-8 -*-

require 'digest/sha2'
require 'securerandom'
require 'active_support/all'

require_relative '_entity/database_information'

module Model
  class Admins
    class <<self
      public

      def verify(id, password)
        admin = Model::Admin.find_by_id(id)
        admin && Model::Helper.start_verify(admin.password, password)
      end

      def add(id, name, password)
        admin =
          Model::Admin.new(
            id: id,
            name: name,
            password: Model::Helper.start_hash(password)
          )
        admin.save
      end

      def remove(id)
        Model::Admin.destroy(id)
        true
      rescue ActiveRecord::RecordNotFound,
             ActiveRecord::StatementInvalid
        false
      end

      def update_password(id, password)
        admin = Model::Admin.find_by_id(id)
        admin.password = Model::Helper.start_hash(password)
        admin.save
      end

    end
  end
end
