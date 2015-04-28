# -*- coding: utf-8 -*-

require 'digest/sha2'
require 'securerandom'

require_relative 'database_information'

class Userslist
  DELIMITER = '$'
  HASH_ITERATIONS = 1000

  def self.hash(password, salt)
    password += salt
    HASH_ITERATIONS.times do
      password = Digest::SHA256.hexdigest(password)
    end
    password
  end
  def self.salt_and_hash(password)
    salt = SecureRandom.base64(24).to_s
    hashed = hash(password, salt)
    hashed + DELIMITER + salt
  end
  def self.verify_password(stored, password)
    correct_hash, salt = stored.split(DELIMITER)
    correct_hash == hash(password, salt)
  end
  def self.valid_password(password)
    /^\w+$/.match(password) != nil
  end
  def self.access(no, password)
    user = User.find_by_no(no)
    if user != nil and
         valid_password(password) and
         verify_password(user.password, password)
       true
    else
       false
    end
  end
  def self.get_nos()
    User.pluck(:no)
  end
  def self.get_names()
    User.pluck(:name)
  end
  def self.clear()
    User.delete_all
    true
  end
  def self.add(no, name, department, password)
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
  def self.remove(no)
    begin
      User.delete(no)
      true
    rescue
      false
    end
  end
  def self.update_name(no, name)
    user = User.find(no)
    user.name = name
    user.save
  end
  def self.update_department(no, department)
    user = User.find(no)
    user.department = department
    user.save
  end
  def self.update_department_all(from, to)
    User.where(department: from).update_all(department: to)
  end
  def self.update_password(no, password)
    user = User.find(no)
    user.password = password
    user.save
  end

  def self.get_name(no)
    user = User.find_by_no(no)
    return user.name
  end

  def self.get_department(no)
    user = User.find_by_no(no)
    return user.department
  end
end
