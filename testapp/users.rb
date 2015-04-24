# -*- coding: utf-8 -*-

require_relative 'database_information'

class UsersAccessError < RuntimeError; end

class Userslist
  @@last_user = nil

  def self.this_no()
    @@last_user.no
  end
  def self.this_name()
    @@last_user.name
  end
  def self.this_department()
    @@last_user.department
  end
  def self.this_password()
    @@last_user.path
  end
  def self.is_wrong_password(db_password, this_password)
    db_password != this_password
  end
  def self.access(no, password)
    u = User.find_by no: no
    if u == nil
      raise UsersAccessError.new("ID:#{no}は登録されていません。")
    elsif is_wrong_password(u.password, password)
      raise UsersAccessError.new("パスワードが間違っています。")
    else
      @@last_user = u
    end
  end
  def self.get_nos()
    User.pluck(:no)
  end
  def self.get_names()
    User.pluck(:name)
  end
  def self.clear()
    User.destroy_all
    true
  end
  def self.include?(no)
    get_nos.include?(no)
  end
  def self.add(no, name, department, password)
    u = User.new()
    u.no = no
    u.name = name
    u.department = department
    u.password = password
    @@last_user = u
    u.save
  end
end
