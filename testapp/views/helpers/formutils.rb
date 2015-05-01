
require 'sinatra'

require_relative '../../departments'

module FormUtils
  def department_options()
    Departments.get_ids.map { |d|
      "<option value=#{d}>#{Departments.name_of(d)}</option>"
    }.join
  end  
end

helpers FormUtils
