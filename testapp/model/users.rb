# -*- coding: utf-8 -*-

require 'digest/sha2'
require 'securerandom'
require 'active_support/all'

require_relative '_entity/database_information'
require_relative './departments'
require_relative './helpers'

module Model
  class Users

    class <<self
      private
      def to_hash(user)
        { user_id: user.id,
          name: user.name,
          department: Model:: Departments.name_of(user.department_id) }
      end

      public

      def verify(id, password)
        user = Model::User.find_by_id(id)
        user && Model::Helper.start_verify(user.password, password)
      end

      def add(id, name, department, password, enter)
        user =
          Model::User.new(
            id: id,
            name: name,
            department_id: Model::Departments.id_of(department),
            password: Model::Helper.start_hash(password),
            enter: enter
          )
        user.save
      end

      def remove(id)
        Model::Timecard.delete_all(user_id: id)
        Model::User.destroy(id)
        true
      rescue ActiveRecord::RecordNotFound,
             ActiveRecord::StatementInvalid
        false
      end

      def update_name(id, name)
        user = Model::User.find(id)
        user.name = name
        user.save
      end

      def update_department(id, department)
        user = Model::User.find(id)
        user.department_id = Model::Departments.id_of(department)
        user.save
      end

      def update_password(id, password)
        user = Model::User.find(id)
        user.password = Model::Helper.start_hash(password)
        user.save
      end

      def get_name(id)
        Model::User.find_by_id(id).try(:name)
      end

      def get_department(id)
        Model::User.find_by_id(id).try(:department)
      end

      def exists?(id)
        User.exists?(id)
      end

      def list_all
        Model::User.all.map { |user| to_hash(user) }
      end

      def status(id)
        user = Model::User.find_by_id(id)
        if user.nil?
          nil
        else
          to_hash(user)
        end
      end

      def get_enter(user_id)
        Model::User.find_by_id(user_id).try(:enter)
      end
=begin      
      def get_usable_vacation_num(user_id)
        p user = Model::User.find_by_id(user_id)
        p this_year = get_business_year(Date.today)
        p enter = user.enter
        carry_over = 0
        p year = enter.year
        while year < this_year do
          carry_over = calculate_carry_over(user_id, enter, year, carry_over)
          year += 1
        end
        p carry_over
        p given = get_given_vacation_num(year, enter)
        p used = Model::Timecard_operation.get_used_vacation_num(user_id, year)
        p  usable_vacation = carry_over + given - used
      end
=end      
    end
  end
end
