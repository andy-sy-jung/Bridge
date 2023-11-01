class PostingsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @postings = Users.all
    end

    def show
      id = params[:id] # retrieve user ID from URI route
      @posting = Users.find(id) # look up posting by unique ID
      # will render app/views/users/show.<extension> by default
    end

    def new

    end

    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def posting__params
      params.require(:type, :name, :subject, :contact).permit(:description, :price, availability)
    end
  end


end