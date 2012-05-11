require_relative 'resource'

class NestedScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

  def initialize(args, *options) #:nodoc:
		super(args, *options)
    parse_reources!
  end

  def copy_view_files
    available_views.each do |view|
      filename = "#{view}.html.erb"
      template "erb/#{filename}", File.join("app/views", r.plural_table_name, filename)
    end
  end

  def copy_controller
    template 'controller.rb', File.join('app/controllers', class_path, "#{r.name}_controller.rb")
  end

  #def add_routes
  #  actions.reverse.each do |action|
  #    route %{get "#{file_name}/#{action}"}
  #  end
  #end

	protected

  def available_views
    %w(index show new edit _form)
  end

	def parse_reources!
  	pr_name, r_name = file_name.split(':')
    @r  ||= Resource.new(r_name.downcase)
    @pr ||= Resource.new(pr_name.downcase)
	end

	def r
		@r
	end

	def pr
		@pr
	end

	def index_helper_path
		uncountable? ? "#{pr_singular_r_plural}_index_path(@#{pr.singular_table_name}})" : "#{pr_singular_r_plural}_path(@#{pr.singular_table_name})"
	end

	def edit_link_path
		"edit_#{singular_path}"
	end

	def singular_path
		"#{pr_singular_r_singular}_path"
	end

	def pr_singular_r_singular
		"#{pr.singular_table_name}_#{r.singular_table_name}"
	end

	def pr_singular_r_plural
		"#{pr.singular_table_name}_#{r.plural_table_name}"
	end

	def controller_class_name
		"#{r.class_name}Controller"
	end

end

unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end