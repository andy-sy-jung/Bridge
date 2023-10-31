class PagesController < ApplicationController
    
    def index
        if session[:loggedIn].nil? or session[:loggedIn] == False
            redirect_to "devise/registration/new"
        end
    end


end
