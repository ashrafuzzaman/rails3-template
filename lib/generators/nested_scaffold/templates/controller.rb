<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  respond_to :js, :json, :html, :xml
  before_filter :load_<%= pr.singular_table_name %>

  def index
  	@<%= plural_table_name %> = @<%= pr.singular_table_name %>.<%= plural_table_name %>
    respond_with(@<%= plural_table_name %>)
  end

  def show
    @<%= singular_table_name %> = @<%= pr.singular_table_name %>.<%= plural_table_name %>.find params[:id]
    respond_with(@<%= singular_table_name %>)
  end

  def new
    @<%= singular_table_name %> = @<%= pr.singular_table_name %>.<%= plural_table_name %>.new
  end

  def edit
    @<%= singular_table_name %> = @<%= pr.singular_table_name %>.<%= plural_table_name %>.find params[:id]
  end

  def create
  	@<%= singular_table_name %> = @<%= pr.singular_table_name %>.<%= plural_table_name %>.build params[:<%= singular_table_name%>]

    respond_to do |format|
      if @<%= singular_table_name %>.save
        format.html { redirect_to [@<%= pr.singular_table_name %>, @<%= singular_table_name %>], notice: <%= "'#{human_name} was successfully created.'" %> }
        format.json { render json: <%= "@#{singular_table_name}" %>, status: :created }
        format.js { flash[:notice] = <%= "'#{human_name} was created.'" %> }
      else
        format.html { render action: "new" }
        format.json { render json: <%= "@#{singular_table_name}.errors" %>, status: :unprocessable_entity }
        format.js { flash[:error] = @<%= singular_table_name %>.errors }
      end
    end
  end

  def update
    @<%= singular_table_name %> = @<%= pr.singular_table_name %>.<%= plural_table_name %>.find params[:id]

    respond_to do |format|
      if @<%= singular_table_name %>.update_attributes(params[:<%= singular_table_name %>])
        format.html { redirect_to [@<%= pr.singular_table_name %>, @<%= singular_table_name %>], notice: <%= "'#{human_name} was successfully updated.'" %> }
        format.json { head :no_content }
        format.js { flash[:notice] = <%= "'#{human_name} was successfully updated.'" %> }
      else
        format.html { render action: "edit" }
        format.json { render json: <%= "@#{singular_table_name}.errors" %>, status: :unprocessable_entity }
        format.js { flash[:error] = @<%= singular_table_name %>.errors }
      end
    end
  end

  def destroy
    @<%= singular_table_name %> = @<%= pr.singular_table_name %>.<%= plural_table_name %>.find params[:id]
    @<%= singular_table_name %>.destroy

    respond_to do |format|
      format.html { redirect_to <%= "#{pr.singular_table_name}_#{plural_table_name}" %>_path }
      format.json { head :no_content }
    end
  end

  private
  def load_<%= pr.singular_table_name %>
  	@<%= pr.singular_table_name %> = <%= pr.class_name %>.find params[:<%= pr.singular_table_name %>_id]
  end
end
<% end -%>
