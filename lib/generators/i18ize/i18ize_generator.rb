class I18izeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def replace
    files.each do |file|
    replace_hash.each_pair { |replace_with, replace_str|  }
      gsub_file file, Regexp.new(replace_str) do |match|
        replace_with
      end 
    end
  end

  private
  def files
    ["app/controllers/#{plural_table_name}_controller.rb"]
  end
  
  def replace_hash
    { "t(:'msg.#{singular_table_name}.created')" => "'#{human_name} was successfully created.'"
    }
  end
end