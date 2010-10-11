class ReportsController < ApplicationController
  before_filter :update_current_user
  before_filter :igb?, :only => [:create]

  # GET /fleet/:fleet_id/reports
  # GET /fleet/:fleet_id/reports.xml
  def index
    @fleet = Fleet.find(params[:fleet_id])
    @reports = @fleet.reports

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end

  # GET /fleet/:fleet_id/reports/1
  # GET /fleet/:fleet_id/reports/1.xml
  def show
    @fleet = Fleet.find(params[:fleet_id])
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report }
    end
  end

  # GET /fleet/:fleet_id/reports/new
  # GET /fleet/:fleet_id/reports/new.xml
  def new
    @fleet = Fleet.find(params[:fleet_id])
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report }
    end
  end

  # GET /fleet/:fleet_id/reports/1/edit
  def edit
    @report = Report.find(params[:id])
  end

  # POST /fleet/:fleet_id/reports
  # POST /fleet/:fleet_id/reports.xml
  def create
    @fleet = Fleet.find(params[:fleet_id])
    # @report = @fleet.reports.create(params[:report])
    @report = @fleet.reports.
                find_or_create_by_fleet_id_and_solar_system_name(@fleet.id, 
                                                                 @user.solar_system_name)
    @report.char_name = @user.char_name
    @report.reds = params[:report][:reds] if params[:report][:reds]
    @report.neutrals = params[:report][:neutrals] if params[:report][:neutrals]

    respond_to do |format|
      if @report.save
        format.html { redirect_to(@fleet, :notice => 'Report was successfully created.') }
        format.xml  { render :xml => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fleet/:fleet_id/reports/1
  # PUT /fleet/:fleet_id/reports/1.xml
  def update
    @fleet = Fleet.find(params[:fleet_id])
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to(@report, :notice => 'Report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fleet/:fleet_id/reports/1
  # DELETE /fleet/:fleet_id/reports/1.xml
  def destroy
    @fleet = Fleet.find(params[:fleet_id])
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to(reports_url) }
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
