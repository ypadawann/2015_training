
require 'active_record'

require_relative 'database_information'

class Departments
  def self.add(no, name)
    new_department = Department.new()
    new_department.no = no
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
