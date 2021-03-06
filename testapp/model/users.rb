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
        {
          user_id: user.id,
          name: user.name,
          department: Model:: Departments.name_of(user.department_id),
          enter_date: { year: user.enter.year,
                        month: user.enter.month,
                        day: user.enter.day }
        }
      end

      public

      def verify(id, password)
        user = Model::User.find_by_id(id)
        user && Model::Helper.start_verify(user.password, password)
      end

      def invalid?(id, name, department, password, enter)
        user =
          Model::User.new(
            id: id,
            name: name,
            department_id: Model::Departments.id_of(department),
            password: Model::Helper.start_hash(password),
            enter: enter
          )
        error_msgs = []
        error_msgs << 'パスワードを入力して下さい。' if password.blank?
        error_msgs << user.errors.messages.values if user.invalid?
        error_msgs
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

      def update(id, name, department, enter_date, password)
        user = Model::User.find(id)
        user.name = name if name.present?
        user.department_id = Model::Departments.id_of(department) if department.present?
        user.enter = [enter_date.year, enter_date.month, enter_date.day].join('-') if enter_date.present?
        user.password = Model::Helper.start_hash(password) if password.present?
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
    end
  end
end
