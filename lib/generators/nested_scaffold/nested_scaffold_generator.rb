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

  protected

	def singular_path
		"#{pr.singular_table_name}_#{singular_table_name}_path"
	end

	def available_views
    %w(index show new edit _form)
  end

  def parse_attributes!
  	parent_ar = self.attributes.to_s.scan(/(\w*):references/)[0]
  	if parent_ar
  		parent = parent_ar[0]
  		say(parent, :green)
  		@pr ||= Resource.new(parent.downcase)
  	end
    super
  end

	def pr
    @pr
	end

end
