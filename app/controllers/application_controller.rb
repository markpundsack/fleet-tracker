class ApplicationController < ActionController::Base
  protect_from_forgery

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
      @user.updated_at = Time.now
      @user.save
    else
      @user = User.new_or_update_from_env_and_save(request.env)
    end
  end
  
  def igb?
    unless @user
      flash[:error] = "IGB Required"
      flash[:notice] = "You must be using the Eve in-game-browser to list or create fleets. If you're already in a fleet, you can copy the direct fleet URL while in-game to your out of game browser."
      render :template => 'pages/about'
    end
  end
  
end
