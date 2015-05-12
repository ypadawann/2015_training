# -*- coding: utf-8 -*-

require 'digest/sha2'
require 'securerandom'
require 'active_support/all'

require_relative 'database_information'

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
      (user = User.find_by_id(id)) &&
        verify_password(user.password, password)
    end

    def add(id, name, department_id, password)
      user = User.new(id: id,
                      name: name,
                      department_id: department_id,
                      password: salt_and_hash(password))
      user.save
    end

    def update_name(id, name)
      user = User.find(id)
      user.name = name
      user.save
    end

    def update_department(id, department)
      user = User.find(id)
      user.department = department
      user.save
    end

    def get_name(id)
      User.find_by_id(id).try(:name)
    end

    def get_department(id)
      User.find_by_id(id).try(:department)
    end
  end
end
