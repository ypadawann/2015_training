# -*- coding: utf-8 -*-

require 'digest/sha2'
require 'securerandom'
require 'active_support/all'

require_relative '_entity/database_information'

module Model
  class Admins
    class <<self
      public
      def to_hash(admin)
        { admin_id: admin.id,
          admin_name: admin.name,}
      end

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

      def update_name(admin_id, admin_name)
        admin = Model::Admin.find_by_id(admin_id)
        admin.name = admin_name
        admin.save
      end

      def update_password(id, password)
        admin = Model::Admin.find_by_id(id)
        admin.password = Model::Helper.start_hash(password)
        admin.save
      end
      
      def status(admin_id)
        admin = Model::Admin.find_by_id(admin_id)
        if admin.nil?
          nil
        else
          to_hash(admin)
        end
      end

      def exists?(admin_id)
        Admin.exists?(admin_id)
      end

    end
  end
end
