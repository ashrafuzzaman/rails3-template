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
    {"t(:created, :scope => [:msg, :#{singular_table_name}])" => "'#{human_name} was successfully created.'",
    "t(:updated, :scope => [:msg, :#{singular_table_name}])" => "'#{human_name} was successfully updated.'",
    "t(:destroy, :scope => [:msg, :#{singular_table_name}])" => "'Destroy'",
    "t(:show, :scope => [:link, :#{singular_table_name}])" => "'Show'",
    "t(:edit, :scope => [:link, :#{singular_table_name}])" => "'Edit'",
    "t(:back, :scope => [:link, :#{singular_table_name}])" => "'Back'",
    "t(:'destroy_confirm', :scope => [:link, :#{singular_table_name}])" => "'Are you sure?'",
    "t(:new, :scope => [:link, :#{singular_table_name}])" => "'New #{human_name}'"}
  end
  
  def language_hash
    {"msg.#{singular_table_name}.created" => "#{human_name} was successfully created.",
    "msg.#{singular_table_name}.updated" => "#{human_name} was successfully updated.",
    "msg.#{singular_table_name}.destroy_confirm" => "Are you sure?",
    "link.#{singular_table_name}.show" => "Show",
    "link.#{singular_table_name}.edit" => "Edit",
    "link.#{singular_table_name}.back" => "Back",
    "link.#{singular_table_name}.destroy" => "Destroy",
    "link.#{singular_table_name}.new" => "New #{human_name}"}
  end
  
  def language_entries
    lng_entries = ''
    language_hash.each do |lng_key, str|
      lng_entries += "  #{lng_key}: #{str}\n"
    end
    lng_entries
  end
end