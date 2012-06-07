require_relative 'resource'
require 'rails/generators/resource_helpers'

class NestedScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
  class_option :stylesheets, :type => :boolean, :desc => "Generate Stylesheets"
  class_option :stylesheet_engine, :desc => "Engine for Stylesheets"

  def initialize(args, *options) #:nodoc:
    parse_reources!(args[0])
    args[0] = r.name
    args << "#{r.name.downcase}:references"
		super(args, *options)
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

  hook_for :test_framework, :in => :rails, :as => :scaffold
  hook_for :messages
  hook_for :helper, :in => :rails, :as => :scaffold do |invoked|
    invoke invoked, [ controller_name ]
  end

  hook_for :orm, :required => true

	protected

  def available_views
    %w(index show new edit _form)
  end

	def parse_reources!(name)
  	pr_name, r_name = name.split(':')
    @r  ||= Resource.new(r_name.downcase)
    @pr ||= Resource.new(pr_name.downcase)
	end

	def r
		@r
	end

	def pr
		@pr
	end

	def controller_name
		"#{class_name}_controller"
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