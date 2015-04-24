
require 'active_record'

require_relative 'database_information'
require_relative 'users'

class DepartmentAccessError < RuntimeError; end

class Departments
  DEFAULT_DEPARTMENT_NO = 0
  DEFAULT_DEPARTMENT = 'その他'

  def self.add(name)
    new_department = Department.new()
    new_department.no = Department.maximum(:no) + 1
    new_department.name = name
    new_department.save
  end
  def self.remove(no)
    begin
      Department.destroy(no)
      true
    rescue ActiveRecord::StatementInvalid => e
      false
    end
  end
  def self.name_of(no)
    department = Department.find(no)
    department.name
  end
  def self.update(no, name)
    department = Department.find(no)
    department.name = name
    department.save
  end
  def self.get_nos()
    Department.pluck(:no)
  end
end
