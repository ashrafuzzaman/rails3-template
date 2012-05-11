require 'rails/generators/base'

class Resource
  attr_reader :name
  alias :singular_name :name

  def initialize(resource_name) #:nodoc:
  	@name = resource_name 
  end

	def class_name
    @class_name ||= file_name.camelize
  end

  def human_name
    @human_name ||= singular_name.humanize
  end

  def plural_name
    @plural_name ||= singular_name.pluralize
  end

  def i18n_scope
    @i18n_scope ||= file_path.tr('/', '.')
  end

  def table_name
    @table_name ||= begin
      base = pluralize_table_names? ? plural_name : singular_name
    end
  end

  def uncountable?
    singular_name == plural_name
  end

  def index_helper
    uncountable? ? "#{plural_table_name}_index" : plural_table_name
  end

  def singular_table_name
    @singular_table_name ||= (pluralize_table_names? ? table_name.singularize : table_name)
  end

  def plural_table_name
    @plural_table_name ||= (pluralize_table_names? ? table_name : table_name.pluralize)
  end

  def plural_file_name
    @plural_file_name ||= file_name.pluralize
  end

  def route_url
    @route_url ||= class_path.collect{|dname| "/" + dname  }.join('') + "/" + plural_file_name
  end

  # Tries to retrieve the application name or simple return application.
  def application_name
    if defined?(Rails) && Rails.application
      Rails.application.class.name.split('::').first.underscore
    else
      "application"
    end
  end

  def assign_names!(name) #:nodoc:
    @class_path = name.include?('/') ? name.split('/') : name.split('::')
    @class_path.map! { |m| m.underscore }
    @file_name = @class_path.pop
  end

  private
  def pluralize_table_names?
    !defined?(ActiveRecord::Base) || ActiveRecord::Base.pluralize_table_names
  end

end