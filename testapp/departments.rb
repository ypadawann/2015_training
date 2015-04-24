
require 'database_information'

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
    department = Department.find_by(no: no)
    department.destroy
  end
  def self.name_of(no)
    department = Department.find_by(no: no)
    department.name
  end
end
