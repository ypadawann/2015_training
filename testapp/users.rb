# -*- coding: utf-8 -*-

require 'digest/sha2'

require_relative 'database_information'

class Userslist
  def self.hash(no, password)
    v = no.to_s + password
    16.times do
      v = Digest::SHA256.hexdigest(v)
    end
    v.to_s.byteslice(0..99)
  end
  def self.is_wrong_password(stored_hash, no, password)
    stored_hash != hash(no, password)
  end
  def self.access(no, password)
    user = User.find_by_no(no)
    p no
    p user
    if user == nil
      return "ID:#{no}は登録されていません。"
    elsif is_wrong_password(user.password, no, password)
      return "パスワードが間違っています。"
    else
      return "true"
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
    if Department.count > 0
      user = User.new(no: no.to_i,
                      name: name, 
                      department: department,
                      password: hash(no, password))
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
end
