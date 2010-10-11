class FleetsController < ApplicationController
  before_filter :update_current_user
  before_filter :igb?, :only => [:index, :join, :leave, :new, :create]
  
  # GET /fleets
  # GET /fleets.xml
  def index
    @fleets = Fleet.visible(@user)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fleets }
    end
  end

  # GET /fleets/1
  # GET /fleets/1.xml
  def show
    @fleet = Fleet.find(params[:id])
    # Calculate summmary
    @sorted_systems = @fleet.summarize

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fleet }
    end
  end

  # GET /fleets/1/join
  def join
    @fleet = Fleet.find(params[:id])
    @user.fleet = @fleet
    if @user.save
      flash[:notice] = "Fleet joined"
      redirect_to @fleet
    else
      flash[:error] = "Failed to join fleet"
      redirect_to root_path
    end
  end

  # GET /fleets/leave
  def leave
    if @user.leave_fleet
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
    @fleet = Fleet.new_from_user(@user)

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
        @user.fleet = @fleet # auto join after creation
        @user.save
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

  private
  
  def update_current_user
    # Total hack for development out of game
    if params[:set_user_id]
      if params[:set_user_id] == "clear"
        # Delete cookie
        cookies[:current_user_id] = nil
      else 
        cookies[:current_user_id] = {:value => params[:set_user_id],
                                     :expires => 1.year.from_now.utc }
      end
    end
    if cookies[:current_user_id]
      @user = User.find(cookies[:current_user_id])
    else
      @user = User.new_from_env(request.env)
    end
  end
  
  def igb?
    #redirect_to igb_required_path unless @user
    render 'igb_required' unless @user
  end
  
end
