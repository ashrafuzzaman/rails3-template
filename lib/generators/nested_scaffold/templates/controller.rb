<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  respond_to :js, :json, :html, :xml
  before_filter :load_<%= pr.singular_table_name %>

  def index
  	@<%= r.plural_table_name %> = @<%= pr.singular_table_name %>.<%= r.plural_table_name %>
    respond_with(@<%= r.plural_table_name %>)
  end

  def show
    @<%= r.orm_instance %> = @<%= pr.singular_table_name %>.<%= r.plural_table_name %>.find params[:id]
    respond_with(@<%= r.orm_instance %>)
  end

  def new
    @<%= r.orm_instance %> = @<%= pr.orm_instance %>.<%= r.plural_table_name %>.new
  end

  def edit
    @<%= r.orm_instance %> = @<%= pr.orm_instance %>.<%= r.plural_table_name %>.find params[:id]
  end

  def create
  	@<%= r.orm_instance %> = @<%= pr.orm_instance %>.<%= r.plural_table_name %>.build params[:<%= r.orm_instance%>]

    respond_to do |format|
      if @<%= r.orm_instance %>.save
        format.html { redirect_to @<%= r.orm_instance %>, notice: <%= "'#{r.human_name} was successfully created.'" %> }
        format.json { render json: <%= "@#{r.orm_instance}" %>, status: :created }
        format.js { flash[:notice] = <%= "'#{r.human_name} was created.'" %> }
      else
        format.html { render action: "new" }
        format.json { render json: <%= "@#{r.orm_instance}.errors" %>, status: :unprocessable_entity }
        format.js { flash[:error] = @<%= r.orm_instance %>.errors }
      end
    end
  end

  def update
    @<%= r.orm_instance %> = @<%= pr.orm_instance %>.<%= r.plural_table_name %>.find params[:id]

    respond_to do |format|
      if @<%= r.orm_instance %>.update_attributes(params[:<%= r.singular_table_name %>])
        format.html { redirect_to @<%= r.orm_instance %>, notice: <%= "'#{r.human_name} was successfully updated.'" %> }
        format.json { head :no_content }
        format.js { flash[:notice] = <%= "'#{r.human_name} was successfully updated.'" %> }
      else
        format.html { render action: "edit" }
        format.json { render json: <%= "@#{r.orm_instance}.errors" %>, status: :unprocessable_entity }
        format.js { flash[:error] = @<%= r.orm_instance %>.errors }
      end
    end
  end

  def destroy
    @<%= r.orm_instance %> = @<%= pr.orm_instance %>.<%= r.plural_table_name %>.find params[:id]
    @<%= r.orm_instance %>.destroy

    respond_to do |format|
      format.html { redirect_to <%= index_helper_path %> }
      format.json { head :no_content }
    end
  end

  private
  def load_<%= pr.singular_table_name %>
  	@<%= pr.orm_instance %> = <%= pr.class_name %>.find params[:<%= pr.singular_table_name %>_id]
  end
end
<% end -%>
