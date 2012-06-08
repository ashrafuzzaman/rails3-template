require 'rails/generators/rails/scaffold/scaffold_generator'
require_relative 'resource'

class NestedScaffoldGenerator < Rails::Generators::ScaffoldGenerator
  source_root File.expand_path('../templates', __FILE__)

  def create_controller_files
    template "controller.rb", File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
  end

  def copy_view_files
    available_views.each do |view|
      filename = "#{view}.html.erb"
      template "erb/#{filename}", File.join("app/views", plural_table_name, filename)
    end
  end

  def add_has_many
		inject_into_class "app/models/#{pr.singular_table_name}.rb", pr.class_name, "  has_many :#{plural_table_name}\n"
  end

  protected

	def singular_path
		"#{pr.singular_table_name}_#{singular_table_name}_path"
	end

	def index_path
		"#{pr.singular_table_name}_#{singular_table_name}_path(@#{pr.singular_table_name})"
	end

	def resource_path
		"[@#{pr.singular_table_name}, @#{singular_table_name}]"
	end

	def available_views
    %w(index show new edit _form)
  end

  def parse_attributes!
  	parent_ar = self.attributes.to_s.scan(/(\w*):references/)[0]
  	if parent_ar
  		parent = parent_ar[0]
  		@pr ||= Resource.new(parent.downcase)
  	end
  	if pr.nil?
  		say 'You need at least one model:references for this to work', :red
  		exit 1
  	end
    super
  end

	def pr
    @pr
	end

end
