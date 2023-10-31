class PagesController < ApplicationController
    
    def index
        if session[:loggedIn].nil? or session[:loggedIn] == False
            redirect_to signup_path
        end
    end


end
