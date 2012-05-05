class AjaxifyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_view_files
    available_views.each do |view|
      filename = "#{view}.js.erb"
      template "erb/#{filename}", "app/views/#{plural_table_name}/#{filename}"
    end
  end

  protected
  def available_views
    %w(show new create edit update delete)
  end
end