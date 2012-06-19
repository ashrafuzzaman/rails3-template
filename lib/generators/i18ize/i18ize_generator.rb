class I18izeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def replace
    files.each do |file|
      gsub_file file, /rake/i do |match|
        "RAKE no more. Use thor!"
      end 
    end
  end

  private
  def files
    ["app/controllers/#{plural_table_name}_controller.rb"]
  end
end