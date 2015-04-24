
require_relative 'database_information'

class Departments
  def self.add(no, name)
    new_department = Department.new()
    new_department.no = no
    new_department.name = name
    begin
      new_department.save
      true
    rescue
      false
    end
  end
  def self.remove(no)
    Department.destroy(no)
  end
  def self.name_of(no)
    department = Department.find(no)
    department.name
  end
  def self.get_nos()
    Department.pluck(:no)
  end
end
