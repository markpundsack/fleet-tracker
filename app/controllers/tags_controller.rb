class TagsController < ApplicationController
  # TODO restrict to fleet admins
  # before_filter :fleet_admin
  # TODO Check or valid user ID
  autocomplete :tag, :text, :full => true

  # GET /users/1/tag
  def add_tag
    @user = User.find(params[:id])
    @tag = Tag.new
  end

  # POST /users/1/tag
  # POST /users/1/tag.xml
  def create_tag
    # TODO could validate that user is in a fleet first
    @user = User.find(params[:id])
    @tag = Tag.find_or_create_by_text(params[:tag][:text])
    @user.tag = @tag

    respond_to do |format|
      if @tag.save
        @user.save
        format.html { redirect_to((@user.fleet ? @user.fleet : @user), :notice => 'Tag was added successfully.') }
        format.xml  { render :xml => @taq, :status => :created, :location => @tag }
      else
        format.html { render :action => "add_tag", :error => "Tag was not added" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/tag
  # DELETE /users/1/tag.xml
  def remove_tag
    @user = User.find(params[:id])
    @user.tag = nil
    @user.save
    respond_to do |format|
      format.html { redirect_to(@user.fleet) }
      format.xml  { head :ok }
    end
  end

end