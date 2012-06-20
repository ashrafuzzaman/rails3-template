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
    "t(:'link.#{singular_table_name}.show')" => "'Show'",
    "t(:'link.#{singular_table_name}.edit')" => "'Edit'",
    "t(:'link.#{singular_table_name}.back')" => "'Back'",
    "t(:'link.#{singular_table_name}.destroy')" => "'Destroy'",
    "t(:'link.#{singular_table_name}.new')" => "'New #{human_name}'"}
  end
end