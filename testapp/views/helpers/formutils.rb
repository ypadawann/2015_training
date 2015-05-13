
require 'sinatra'

require_relative '../../model/departments'

module FormUtils
  def department_options
    Departments.list_ids.map do |d|
      "<option value=#{d}>#{Departments.name_of(d)}</option>"
    end.join
  end
end

helpers FormUtils
