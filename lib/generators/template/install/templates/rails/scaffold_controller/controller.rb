<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  respond_to :js, :json, :html, :xml

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    respond_with(@<%= plural_table_name %>)
  end

  def show
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with(@<%= singular_table_name %>)
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>

    respond_to do |format|
      if @<%= orm_instance.save %>
        format.html { redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully created.'" %> }
        format.json { render json: <%= "@#{singular_table_name}" %>, status: :created, location: <%= "@#{singular_table_name}" %> }
        format.js { flash[:notice] = <%= "'#{human_name} was successfully created.'" %> }
      else
        format.html { render action: "new" }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
        format.js { flash[:error] = @<%= singular_table_name %>.errors }
      end
    end
  end

  def update
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>

    respond_to do |format|
      if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
        format.html { redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} was successfully updated.'" %> }
        format.json { head :no_content }
        format.js { flash[:notice] = <%= "'#{human_name} was successfully updated.'" %> }
      else
        format.html { render action: "edit" }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
        format.js { flash[:error] = @<%= singular_table_name %>.errors }
      end
    end
  end

  def destroy
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>

    respond_to do |format|
      format.html { redirect_to <%= index_helper %>_url }
      format.json { head :no_content }
    end
  end
end
<% end -%>
