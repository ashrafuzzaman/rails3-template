require 'rails/generators'

module Template
  module Generators
		class InstallGenerator < Rails::Generators::NamedBase
		  source_root File.expand_path('../templates', __FILE__)

		  def copy_view_templates
		    available_view_templates.each do |file|
		      copy_file "erb/scaffold/#{name}/#{file}.html.erb", 
		      			"lib/templates/erb/scaffold/#{file}.html.erb"
		    end
		  end

		  def copy_controller_template
		  	file_with_ext = "rails/scaffold_controller/controller.rb"
	        copy_file file_with_ext, "lib/templates/#{file_with_ext}"
		  end

		  def copy_helper_template
		  	file_with_ext = "rails/helper/helper.rb"
	        copy_file file_with_ext, "lib/templates/#{file_with_ext}"
		  end

      def copy_shared_templates
        file_with_ext = "erb/scaffold/#{name}/shared/_notifications.html.erb"
          copy_file file_with_ext, "app/views/shared/_notifications.html.erb"
      end

		  private
		  	def available_view_templates
		      %w(show new edit _form index)
	    	end
		end
	end
end
