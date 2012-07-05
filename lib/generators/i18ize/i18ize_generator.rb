class I18izeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def replace
    files.each do |file|
      replace_hash.each do |replace_with, replace_str|
        gsub_file file, Regexp.new(replace_str) do |match|
          replace_with
        end
      end 
    end
    #Finally add these to the language files
    append_file 'config/locales/en.yml', language_entries
  end

  private
  def files
    @files ||= ["app/controllers/#{plural_table_name}_controller.rb",
    "app/views/#{plural_table_name}/edit.html.erb",
    "app/views/#{plural_table_name}/_form.html.erb",
    "app/views/#{plural_table_name}/index.html.erb",
    "app/views/#{plural_table_name}/new.html.erb",
    "app/views/#{plural_table_name}/show.html.erb",]
  end
  
  def replace_hash
    {"t(:'msg.#{singular_table_name}.created')" => "'#{human_name} was successfully created.'",
    "t(:'msg.#{singular_table_name}.updated')" => "'#{human_name} was successfully updated.'",
    "t(:'msg.#{singular_table_name}.destroy')" => "'Destroy'",
    "t(:'link.#{singular_table_name}.show')" => "'Show'",
    "t(:'link.#{singular_table_name}.edit')" => "'Edit'",
    "t(:'link.#{singular_table_name}.back')" => "'Back'",
    "t(:'link.#{singular_table_name}.destroy_confirm')" => "'Are you sure?'",
    "t(:'link.#{singular_table_name}.new')" => "'New #{human_name}'"}
  end
  
  def language_entries
    lng_entries = "\n  msg:\n"
    lng_entries << "    #{singular_table_name}:\n"
    lng_entries << language_sub_entries({"created" => "#{human_name} was successfully created.",
        "updated" => "#{human_name} was successfully updated.",
        "destroy_confirm" => "Are you sure?"})

    lng_entries << "  link:\n"
    lng_entries << "    #{singular_table_name}:\n"
    lng_entries << language_sub_entries({"show" => "Show",
																		    "edit" => "Edit",
																		    "back" => "Back",
																		    "destroy" => "Destroy",
																		    "new" => "New #{human_name}"})
    lng_entries
  end

  def language_sub_entries(hash)
  	lng_entries = ''
		hash.each do |lng_key, str|
      lng_entries << "      #{lng_key}: #{str}\n"
    end
    lng_entries  	
  end
end