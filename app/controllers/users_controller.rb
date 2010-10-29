class UsersController < ApplicationController
  before_filter :update_current_user, :except => [:ping]
  before_filter :admin_user, :except => [:ping, :purge, :show]

  # GET /ping.html
  # GET /ping.js
  def ping
    if cookies[:current_user_id]
      @user = User.find(cookies[:current_user_id])
    else
      @user = User.new_or_update_from_env(request.env)
    end
    @current_user_changed = @user.changed?
    @user.updated_at = Time.now # To force an update
    @user.save
    respond_to do |format|
      format.html { render @curent_user_changed ? 'ping_unchanged' : 'ping' }
      format.js
    end
  end
  
  # POST /users/purge
  def purge
    @users = User.abondoned.map(&:destroy)
  end
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    
    if (@current_user && @current_user.global_admin?) || (@user.fleet && @user.fleet.admin?(@current_user) || @user == @current_user)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end
    else
      flash[:error] = "You are not authorized to view this user."
      redirect_to root_path
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    if request.env["HTTP_EVE_TRUSTED"]
      @user.set_from_env(request.env)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def fleet_admin
    unless global_admin? || (@user.fleet && @user.fleet.admin?(@current_user))
      flash[:error] = "You are not authorized."
      redirect_to root_path
    end
  end
  
end
