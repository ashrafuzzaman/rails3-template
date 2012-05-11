<% module_namespacing do -%>
module <%= class_name %>Helper
	def <%= singular_table_name %>_form_title(<%= singular_table_name %>)
		<%= singular_table_name %>.new_record? ? "New <%= singular_table_name %>" : "Editing <%= singular_table_name %>"
	end
end
<% end -%>
