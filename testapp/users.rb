# -*- coding: utf-8 -*-

require_relative 'database_information'

class UsersAccessError < RuntimeError; end

class Userslist
  def self.is_wrong_password(db_password, this_password)
    db_password != this_password
  end
  def self.access(no, password)
    u = User.find_by no: no
    if u == nil
      raise UsersAccessError.new("ID:#{no}は登録されていません。")
    elsif is_wrong_password(u.password, password)
      raise UsersAccessError.new("パスワードが間違っています。")
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
  def self.include?(no)
    get_nos.include?(no)
  end
  def self.add(no, name, department, password)
    if Department.count > 0
      user = User.new(no: no.to_i, name: name, department: department, password: password)
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
