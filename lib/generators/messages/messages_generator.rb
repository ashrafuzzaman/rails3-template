class MessagesGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_view_files
    available_views.each do |view|
      filename = "#{view}.html.erb"
      template "erb/#{filename}", File.join("app/views/shared", filename)
    end
  end

private
  def available_views
    %w(_errors _notifications)
  end

end