
require 'active_record'

require_relative 'database_information'

class Departments
  DEFAULT_DEPARTMENT_ID = 0
  DEFAULT_DEPARTMENT = 'その他'

  def self.add(name)
    new_department = Department.new()
    new_department.name = name
    new_department.save
  end
  def self.remove(id)
    begin
      Department.destroy(id)
      true
    rescue ActiveRecord::StatementInvalid => e
      false
    end
  end
  def self.name_of(id)
    department = Department.find(id)
    department.name
  end
  def self.update(id, name)
    department = Department.find(id)
    department.name = name
    department.save
  end
  def self.get_ids()
    Department.pluck(:id)
  end
  def self.valid_department(id)
    get_ids.include?(id)
  end
end
