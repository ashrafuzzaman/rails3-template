require 'rails/generators'

module Template
  module Generators
		class InstallGenerator < ::Rails::Generators::Base
		  source_root File.expand_path('../templates', __FILE__)

		  def copy_view_templates
		    available_view_templates.each do |file|
		    	file_with_ext = "erb/scaffold/#{file}.html.erb"
		      copy_file file_with_ext, "lib/templates/#{file_with_ext}"
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

		  private
		  	def available_view_templates
			    %w(show new edit _form index)
			  end
		end
	end
end
