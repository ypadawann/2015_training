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
      hashed + DELIMITER + salt
    end
    def verify_password(stored, password)
      correct_hash, salt = stored.split(DELIMITER)
      correct_hash == hash(password, salt)
    end
    def valid_password(password)
      /^\w+$/.match(password) != nil
    end
  
    public
    def access(no, password)
      user = User.find_by_no(no)
      if user != nil and
           valid_password(password) and
           verify_password(user.password, password)
         true
      else
         false
      end
    end
    def get_nos()
      User.pluck(:no)
    end
    def get_names()
      User.pluck(:name)
    end
    def clear()
      User.delete_all
      true
    end
    def add(no, name, department, password)
      if Department.count > 0 and valid_password(password)
        user = User.new(no: no.to_i,
                        name: name, 
                        department: department,
                        password: salt_and_hash(password))
        user.save
      else
        false
      end
    end
    def remove(no)
      begin
        User.delete(no)
        true
      rescue
        false
      end
    end
    def update_name(no, name)
      user = User.find(no)
      user.name = name
      user.save
    end
    def update_department(no, department)
      user = User.find(no)
      user.department = department
      user.save
    end
    def update_department_all(from, to)
      User.where(department: from).update_all(department: to)
    end
    def update_password(no, password)
      user = User.find(no)
      user.password = password
      user.save
    end
    def get_name(no)
      user = User.find_by_no(no)
      return user.name
    end
    def get_department(no)
      user = User.find_by_no(no)
      return user.department
    end
  end
end
