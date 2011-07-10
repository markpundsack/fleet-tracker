class FleetsController < ApplicationController
  before_filter :get_current_user#, :except => [:index, :show]
  # before_filter :get_current_user_and_force_update, :only => [:index, :show]
  before_filter :require_igb, :only => [:index, :join, :leave, :new, :create]
  before_filter :check_fleet_id, :only => [:show, :join, :purge, :edit, :update, :destroy]
  # TODO Find a way to do this as a background task instead
  before_filter :purge_fleets, :only => [:index]
  
  # GET /fleets
  # GET /fleets.xml
  def index
    @fleets = ((@current_user && @current_user.global_admin?) ? Fleet.with_deleted : Fleet.visible(@current_user))

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fleets }
    end
  end

  # def purge
  #   @fleet = Fleet.find(params[:id])
  #   @users = @fleet.purge_users
  # end
  
  # GET /fleets/1
  # GET /fleets/1.xml
  # GET /fleets/1.js
  def show
    @fleet = Fleet.find(params[:id])
    
    you_hacker unless @fleet.access_by?(@current_user)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fleet }
      format.js
    end
  end

  # GET /fleets/1/join
  def join
    @fleet = Fleet.find(params[:id])
    if @current_user.join_fleet(@fleet)
      redirect_to @fleet, :notice => "Fleet joined"
    else
      redirect_to root_path, :error => "Failed to join fleet"
    end
  end

  # GET /fleets/leave
  def leave
    if @current_user.leave_fleet
      redirect_to root_path, :notice => "Fleet cleared"
    else
      redirect_to root_path, :error => "Failed to leave fleet"
    end
  end

  # GET /fleets/new
  # GET /fleets/new.xml
  def new
    @fleet = Fleet.new_from_user(@current_user)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fleet }
    end
  end

  # GET /fleets/1/edit
  def edit
    @fleet = Fleet.find(params[:id])
  end

  # POST /fleets
  # POST /fleets.xml
  def create
    @fleet = Fleet.new(params[:fleet])

    respond_to do |format|
      if @fleet.save
        @current_user.join_fleet(@fleet) # auto join after creation
        format.html { redirect_to(@fleet, :notice => 'Fleet was successfully created.') }
        format.xml  { render :xml => @fleet, :status => :created, :location => @fleet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fleet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fleets/1
  # PUT /fleets/1.xml
  def update
    @fleet = Fleet.find(params[:id])

    respond_to do |format|
      if @fleet.update_attributes(params[:fleet])
        format.html { redirect_to(@fleet, :notice => 'Fleet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fleet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fleets/1
  # DELETE /fleets/1.xml
  def destroy
    @fleet = Fleet.find(params[:id])
    @fleet.destroy

    respond_to do |format|
      format.html { redirect_to(fleets_url) }
      format.xml  { head :ok }
    end
  end

  protected
  
  def check_fleet_id
    you_hacker unless Fleet.exists?(params[:id])
  end
  
  def you_hacker    
    redirect_to root_path, :notice => "You hacker!"
  end
  
  def purge_fleets
    User.purge
    Fleet.purge
  end
  
end
