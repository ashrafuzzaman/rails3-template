require_relative 'resource'

class NestedScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  attr_accessor :pr, :r

  def copy_view_files
  	r_name, pr_name = file_name.split('/')
    self.r, self.pr = Resource.new(r_name), Resource.new(pr_name)
    available_views.each do |view|
    	file = "#{view}.html.erb"
      template "erb/scaffold/#{file}", "app/views/#{r.plural_table_name}/#{file}"
    end
  end

	private
  def available_views
    %w(show)
  end

end

unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end