class FleetsController < ApplicationController
  before_filter :update_current_user
  before_filter :using_igb, :only => [:index, :join, :leave, :new, :create]
  
  # GET /fleets
  # GET /fleets.xml
  def index
    @fleets = ((@current_user && @current_user.global_admin?) ? Fleet.all : Fleet.visible(@current_user))

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fleets }
    end
  end

  def purge
    @fleet = Fleet.find(params[:id])
    @users = @fleet.users.where(['updated_at < ?', 10.minutes.ago])
    @users.map(&:leave_fleet)
  end
  
  # GET /fleets/1
  # GET /fleets/1.xml
  # GET /fleets/1.js
  def show
    if (Fleet.exists?(params[:id]))
      @fleet = Fleet.find(params[:id])
      if @fleet.direct_access || @fleet.visible_to?(@current_user)
        respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @fleet }
          format.js
        end
        return
      end
    end
    flash[:notice] = "You hacker!"
    redirect_to root_path
  end

  # GET /fleets/1/join
  def join
    @fleet = Fleet.find(params[:id])
    if @current_user.join_fleet(@fleet)
      flash[:notice] = "Fleet joined"
      redirect_to @fleet
    else
      flash[:error] = "Failed to join fleet"
      redirect_to root_path
    end
  end

  # GET /fleets/leave
  def leave
    if @current_user.leave_fleet
      flash[:notice] = "Fleet cleared"
      redirect_to root_path
    else
      flash[:error] = "Failed to leave fleet"
      redirect_to root_path
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
        @current_user.fleet = @fleet # auto join after creation
        @current_user.save
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

end
