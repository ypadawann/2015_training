
require 'active_record'

require_relative 'database_information'
require_relative 'users'

class Departments
  def self.add(name)
    new_department = Department.new()
    max_no = Department.maximum(:no)
    if max_no == nil
      new_department.no = 1
    else
      new_department.no = max_no + 1
    end
    new_department.name = name
    new_department.save
  end
  def self.remove(name)
    begin
      department = Department.find_by(name: name)
      department.destroy
      true
    rescue
      false
    end
  end
  def self.name_of(no)
    department = Department.find(no)
    department.name
  end
  def self.get_nos()
    Department.pluck(:no)
  end
end
