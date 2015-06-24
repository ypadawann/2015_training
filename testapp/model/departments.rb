
require 'active_record'
require 'active_support/all'

require_relative '_entity/database_information'

module Model
  class Departments
    def self.add(name)
      new_department = Model::Department.new
      new_department.name = name
      new_department.save
    end

    def self.remove(id)
      Model::Department.destroy(id)
      true
    rescue ActiveRecord::RecordNotFound,
           ActiveRecord::StatementInvalid
      false
    end

    def self.name_of(id)
      Model::Department.find_by_id(id).try(:name)
    end

    def self.id_of(name)
      Model::Department.find_by_name(name).try(:id)
    end

    def self.update(id, name)
      department = Model::Department.find(id)
      department.name = name
      department.save
    end

    def self.list_names
      Model::Department.pluck(:name)
    end

    def self.list_ids
      Model::Department.pluck(:id)
    end

    def self.users(id)
      name = name_of(id)
      Model::Users.list_all.select { |user|
        user[:department] == name
      }
    end

    def self.exists?(id)
      Model::Department.exists?(id)
    end

    def self.name_exists?(name)
      Model::Department.exists?(name: name)
    end

  end
end
