
require 'active_record'
require 'active_support/all'

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
  rescue ActiveRecord::RecordNotFound,
         ActiveRecord::StatementInvalid
    false
  end

  def self.name_of(id)
    Department.find_by_id(id).try(:name)
  end

  def self.id_of(name)
    Department.find_by_name(name).try(:id)
  end

  def self.update(id, name)
    department = Department.find(id)
    department.name = name
    department.save
  end

  def self.list_names
    Department.pluck(:name)
  end

  def self.list_ids
    Department.pluck(:id)
  end

  def self.users(id)
    Users.list_all.select { |user|
      user.department_id == id
    }
  end
end
