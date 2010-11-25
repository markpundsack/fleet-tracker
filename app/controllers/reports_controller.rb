class ReportsController < ApplicationController
  # before_filter :get_current_user_and_force_update
  before_filter :require_igb, :only => [:create]  
  before_filter :require_global_admin, :except => [:create]
  
  # TODO Remove extraneous actions

  # GET /fleet/:fleet_id/reports
  # GET /fleet/:fleet_id/reports.xml
  # GET /fleet/:fleet_id/reports.js
  def index
    @fleet = Fleet.find(params[:fleet_id])
    @reports = @fleet.reports
    if params[:after]
      @reports = @reports.where("updated_at > ?", Time.at(params[:after].to_i + 1))
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
      format.js  { render @fleets }
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
                                                                 @current_user.solar_system_name)
    @report.char_name = @current_user.char_name
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

end
