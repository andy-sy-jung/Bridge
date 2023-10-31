class PagesController < ApplicationController
    
    def index
        session[:loggedIn] = params[:loggedIn]
        if session[:loggedIn].nil? or session[:loggedIn] == false
            redirect_to new_user_session_path
        end
    end


end
