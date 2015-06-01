
require 'sinatra'

module ControllerHelpers
  def show_erb
    path = request.path
    path.slice!(0, 1)
    if File.exist?("#{settings.views}/#{path}.erb")
      erb "#{path}".to_sym
    else
      raise Sinatra::NotFound.new
    end
  end

  def app_path
    "#{request.scheme}://#{request.host_with_port}#{request.script_name}"
  end

  def js_path
    "#{app_path}/dist/js"
  end

  def css_path
    "#{app_path}/dist/style"
  end
end
