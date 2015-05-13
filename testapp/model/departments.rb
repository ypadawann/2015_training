
require 'active_record'

require_relative '_entity/database_information'

class Departments
  def self.add(name)
    new_department = Department.new
    new_department.name = name
    new_department.save
  end

  def self.remove(id)
    Department.destroy(id)
    true
  rescue ActiveRecord::StatementInvalid
    false
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

  def self.list_ids
    Department.pluck(:id)
  end
end
