class CustomSessionsController < Devise::SessionsController
    protected
  
    def after_sign_in_path_for(resource)
      # Redirect to your main page (index) with the loggedIn parameter
      index_path(loggedIn: true)
    end

    def after_sign_out_path_for(resource)
        new_user_session_path
    end


  end
  