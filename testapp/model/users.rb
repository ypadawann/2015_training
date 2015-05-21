# -*- coding: utf-8 -*-

require 'digest/sha2'
require 'securerandom'
require 'active_support/all'

require_relative '_entity/database_information'
require_relative './departments'

module Model
  class Users
    DELIMITER = '$'
    HASH_ITERATIONS = 1000

    class <<self
      private

      def hash(password, salt)
        password += salt
        HASH_ITERATIONS.times do
          password = Digest::SHA256.hexdigest(password)
        end
        password
      end

      def salt_and_hash(password)
        salt = SecureRandom.base64(24).to_s
        hashed = hash(password, salt)
        "#{hashed}#{DELIMITER}#{salt}"
      end

      def verify_password(stored, password)
        correct_hash, salt = stored.split(DELIMITER)
        correct_hash == hash(password, salt)
      end

      public

      def access(id, password)
        (user = Model::User.find_by_id(id)) &&
          verify_password(user.password, password)
      end

      def add(id, name, department, password)
        user =
          Model::User.new(
            id: id,
            name: name,
            department_id: Model::Departments.id_of(department),
            password: salt_and_hash(password)
          )
        user.save
      end

      def remove(id)
        Model::User.destroy(id)
        true
      rescue ActiveRecord::RecordNotFound,
             ActiveRecord::StatementInvalid
        false
      end

      def update_name(id, name)
        user = Model::User.find(id)
        user.name = name
        user.save
      end

      def update_department(id, department)
        user = Model::User.find(id)
        user.department = department
        user.save
      end

      def get_name(id)
        Model::User.find_by_id(id).try(:name)
      end

      def get_department(id)
        Model::User.find_by_id(id).try(:department)
      end

      def list_all
        Model::User.all
      end

      def status(id)
        user = Model::User.find_by_id(id)
        if user.nil?
          nil
        else
          { user_id: user.id,
            name: user.name,
            department: Model:: Departments.name_of(user.department_id) }
        end
      end
    end
  end
end
