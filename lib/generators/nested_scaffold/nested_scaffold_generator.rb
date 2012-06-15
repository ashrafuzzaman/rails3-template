require 'rails/generators/rails/scaffold/scaffold_generator'
require_relative 'resource'

class NestedScaffoldGenerator < Rails::Generators::ScaffoldGenerator
  source_root File.expand_path('../templates', __FILE__)

  def create_controller_files
    template "controller.rb", File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
  end

  def add_has_many
		inject_into_class "app/models/#{pr.singular_table_name}.rb", pr.class_name, "  has_many :#{plural_table_name}\n"
  end

  def add_in_routes
		gsub_file 'config/routes.rb', Regexp.new("resources :#{plural_table_name}\n"), ''
		gsub_file 'config/routes.rb', Regexp.new("resources :#{pr.plural_table_name}\n"), "resources :#{pr.plural_table_name} do\n  end\n"
	  inject_into_file 'config/routes.rb', "\n    resources :#{plural_table_name}", :after => "resources :#{pr.plural_table_name} do"
  end

  def modify_view_files
    template_eng = Rails.application.config.generators.options[:rails][:template_engine] || 'erb'

    modify_edit_view(plural_table_name)
    modify_form(plural_table_name)
    modify_index_view(plural_table_name)
		modify_show_view(plural_table_name)
		modify_new_view(plural_table_name)    
  end

  protected

  def modify_resource_link(plural_table_name, file_name)
    gsub_file File.join("app/views", plural_table_name, file_name), 
    					Regexp.new("(<%= link_to.*,\s*)(@?#{singular_table_name})(\s*,.*%>|\s*%>)"), 
    					"\\1[@#{pr.singular_table_name}, \\2]\\3"
  end

  def modify_edit_link(plural_table_name, file_name)
    gsub_file File.join("app/views", plural_table_name, file_name), 
    					Regexp.new("edit_#{singular_table_name}_path\\((@?#{singular_table_name})\\)"), 
    					"edit_#{singular_path}(@#{pr.singular_table_name}, \\1)"
  end

  def modify_index_link(plural_table_name, file_name)
    gsub_file File.join("app/views", plural_table_name, file_name), 
    					Regexp.new("#{index_helper}_path"), 
    					index_path
  end

  def modify_edit_view(plural_table_name)
    file_name = "edit.html.erb"
    modify_resource_link(plural_table_name, file_name)
		modify_index_link(plural_table_name, file_name)
  end

  def modify_form(plural_table_name)
  	file_name = "_form.html.erb"
    gsub_file File.join("app/views", plural_table_name, file_name), 
				Regexp.new("(form_for.*)@#{singular_table_name}(.*do)"), 
				"\\1#{resource_path}\\2"
		modify_index_link(plural_table_name, file_name)
  end

  def modify_index_view(plural_table_name)
  	file_name = "index.html.erb"
    modify_resource_link(plural_table_name, file_name)
		modify_edit_link(plural_table_name, file_name)
    gsub_file File.join("app/views", plural_table_name, file_name), 
				Regexp.new("new_#{singular_table_name}_path"), 
				"new_#{singular_path}(@#{pr.singular_table_name})"
  end

  def modify_show_view(plural_table_name)
    file_name = "show.html.erb"
    modify_edit_link(plural_table_name, file_name)
		modify_index_link(plural_table_name, file_name)
  end

  def modify_new_view(plural_table_name)
    file_name = "new.html.erb"
		modify_index_link(plural_table_name, file_name)
  end

	def singular_path
		"#{pr.singular_table_name}_#{singular_table_name}_path"
	end

	def index_path
		"#{pr.singular_table_name}_#{plural_table_name}_path(@#{pr.singular_table_name})"
	end

	def resource_path
		"[@#{pr.singular_table_name}, @#{singular_table_name}]"
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
