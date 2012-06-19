class I18izeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def replace
    files.each do |file|
      gsub_file file, /rake/, :green do |match|
        match << " no more. Use thor!"
      end 
    end
  end

  private
  def files
    %w(app/controllers/#{controller_file_name}_controller.rb)
  end
end