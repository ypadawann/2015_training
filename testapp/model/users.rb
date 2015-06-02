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


      def get_business_year(date)
          if date.month >= 4
            date.year
          else
            date.year - 1
          end
      end

      def is_training?(enter)
        p finish_date = enter >> 4
        if finish_date > Date.today
          return true
        else
          return false
        end
      end

      def newly_paid_vacation(enter)
        if is_training?(enter)
          return 1
        end
        return temp =
          case enter.month
          when 4..9
            10
          when 10
            5
          when 11
            4
          when 12
            3
          when 1
            2
          when 2
            1
          when 3
          end
      end

      def get_given_vacation_num(year, enter)
        job_length = year - get_business_year(enter)
        if job_length < 0
          return 0
        end
        return temp =
          case  job_length
          when 0 then
            newly_paid_vacation(enter)
          when 1 then
            11
          when 2 then
            12
          when 3 then
            14
          when 4 then
            16
          when 5 then
            18
          else 
            20
          end
      end

      def calculate_carry_over(user_id, enter, year, carry_over)
        given = get_given_vacation_num(year, enter)
        used = get_used_vacation_num(user_id, year)
        if used > carry_over
          carry_over + given - used
        else
          given
        end
      end

      def get_used_vacation_num(user_id, year)
        timecard = Timecard.where(user_id: user_id).where(day: "#{year}-04-01".."#{year+1}-03-30")
        use_paid_vacation = 0
        timecard.each do |t|
          use_paid_vacation += t.paid_vacation unless t.paid_vacation.nil?
        end
        return use_paid_vacation
      end
      
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
        p used = get_used_vacation_num(user_id, year)
        p  usable_vacation = carry_over + given - used
      end
      
    end
  end
end
