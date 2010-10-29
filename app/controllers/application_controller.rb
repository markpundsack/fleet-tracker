class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_current_user
    # Total hack for development out of game
    if params[:set_user_id]
      if params[:set_user_id] == "clear"
        cookies.delete :current_user_id
      else 
        cookies[:current_user_id] = {:value => params[:set_user_id],
                                     :expires => 1.year.from_now.utc }
      end
    end
    if cookies[:current_user_id]
      @current_user = User.find(cookies[:current_user_id])
      @current_user.updated_at = Time.now
      @current_user.save
    else
      @current_user = User.new_or_update_from_env_and_save(request.env)
    end
  end
  
  def using_igb
    unless @current_user
      flash.now[:error] = "IGB and Trusted Site Required"
      flash.now[:notice] = "You must be using the Eve in-game-browser and mark the site as 'trusted' to list or create fleets. If you're already in a fleet, you can copy the direct fleet URL while in-game to your out of game browser."
      render :template => 'pages/about'
    end
  end
  
  def admin_user
    unless @current_user && @current_user.global_admin? 
      flash[:error] = "You must be an administrator to perform that action."
      redirect_to root_path 
    end
  end
  
end
