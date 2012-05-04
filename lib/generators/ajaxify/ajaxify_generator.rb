class AjaxifyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_initializer_file
    template "erb/create.js.erb", "app/views/#{plural_table_name}/create.js.erb"
  end
end