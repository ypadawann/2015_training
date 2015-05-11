# -*- coding: utf-8 -*-

require 'digest/sha2'
require 'securerandom'

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

    def valid_id(id)
      0 < id && id < 10_000
    end

    public

    def access(id, password)
      user = User.find_by_id(id)
      if user.nil? && verify_password(user.password, password)
        true
      else
        false
      end
    end

    def add(id, name, department, password)
      if valid_id(id) && Departments.valid_department(department)
        user = User.new(id: id,
                        name: name,
                        department: department,
                        password: salt_and_hash(password))
        user.save
      else
        false
      end
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

    def update_password(id, password)
      user = User.find(id)
      user.password = password
      user.save
    end

    def get_name(id)
      user = User.find_by_id(id)
      if user.nil?
        nil
      else
        user.name
      end
    end

    def get_department(no)
      user = User.find_by_id(no)
      user.department
    end
  end
end
