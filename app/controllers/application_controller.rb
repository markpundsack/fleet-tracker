class ApplicationController < ActionController::Base
  protect_from_forgery

  # Get current user
  # mock_current_user_id cookie overrides everything for testing purposes
  # current_user_id cookie speeds up search, but is still validated against http headers
  # updates database if user info has changed or if force_update is true
  # TODO: Should last_user_id be a session variable?
  def get_current_user(force_update = false)
    # Total hack for development out of game
    if params[:set_user_id]
      if params[:set_user_id] == "clear"
        cookies.delete :mock_current_user_id
      else 
        cookies[:mock_current_user_id] = {:value => params[:set_user_id], :expires => 1.year.from_now.utc }
      end
    end
    if cookies[:mock_current_user_id].to_i > 0
      @current_user = User.find(cookies[:mock_current_user_id]) # don't bother rescuing for development
      if force_update
        @current_user.updated_at = Time.now
        @current_user.save
      end
      return
    end
    return if request.env["HTTP_EVE_CHARNAME"].blank?
    if cookies[:last_user_id].to_i > 0
      @current_user = User.find(cookies[:last_user_id])
      # TODO add rescue just in case the cookie is invalid or out of date
      # Validate @current_user from cookie with environment, including if no env passed
      @current_user = nil if @current_user.char_name != request.env["HTTP_EVE_CHARNAME"]
    end
    if @current_user.nil?
      # find character by char_name if it exists
      @current_user = User.find_or_initialize_from_env(request.env)
    end
    @current_user.set_from_env(env)
    @current_user_changed = true if @current_user.changed?
    @current_user.updated_at = Time.now if force_update
    # Note: if model hasn't changed, .save won't actually bother saving
    @current_user.save
    cookies[:last_user_id] = {:value => @current_user.id, :expires => 1.year.from_now.utc }
  end
  
  def get_current_user_and_force_update
    get_current_user(true)
  end
  
  def require_igb
    unless @current_user
      flash.now[:error] = "IGB and Trusted Site Required"
      flash.now[:notice] = "You must be using the Eve in-game-browser and mark the site as 'trusted' to list or create fleets. If you're already in a fleet, you can copy the direct fleet URL while in-game to your out of game browser."
      @request_trust = true
      render :template => 'pages/about'
    end
  end
  
  def require_global_admin
    unless @current_user && @current_user.global_admin? 
      flash[:error] = "You must be an administrator to perform that action."
      redirect_to root_path 
    end
  end
  
end
