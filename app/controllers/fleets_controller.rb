class FleetsController < ApplicationController
  before_filter :update_user
  
  # GET /fleets
  # GET /fleets.xml
  def index
    @fleets = Fleet.all

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
    @system = {}
    @fleet.users.each do |user|
      if @system[user.solar_system_name].nil?
        @system[user.solar_system_name] = [user]
      else
        @system[user.solar_system_name] << user
      end
    end
    @sorted_systems = @system.sort {|a,b| a[1].count<=>b[1].count}
    @sorted_systems.reverse!

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
      redirect_to @fleet
    else
      flash[:error] = "Failed to join fleet"
      redirect_to root_path
    end
  end

  # GET /fleets/new
  # GET /fleets/new.xml
  def new
    @fleet = Fleet.new
    @fleet.display_pilot_count = true;
    @fleet.display_fc_info = true;
    @fleet.scope = 2 #alliance
    if @user
      @fleet.title = "#{@user.char_name}'s Fleet"
      @fleet.fc = @user.char_name
      @fleet.xo = @user.char_name
      @fleet.created_by = @user.char_name
      @fleet.corp_name = @user.corp_name
      @fleet.alliance_name = @user.alliance_name
    end

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
        @user.fleet=@fleet
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
  def update_user
    if !request.env["HTTP_EVE_CHARNAME"].blank?
      @user = User.find_or_initialize_by_char_name(request.env["HTTP_EVE_CHARNAME"])
      # set everything just in case member has changed corp, etc.
      @user.corp_name = request.env["HTTP_EVE_CORPNAME"]
      @user.alliance_name = request.env["HTTP_EVE_ALLIANCENAME"]
      @user.region_name = request.env["HTTP_EVE_REGIONNAME"]
      @user.constellation_name = request.env["HTTP_EVE_CONSTELLATIONNAME"]
      @user.solar_system_name = request.env["HTTP_EVE_SOLARSYSTEMNAME"]
      @user.station_name = request.env["HTTP_EVE_STATIONNAME"]
      @user.updated_at = Time.now # To force an update
      @user.save
    end
  end
end
