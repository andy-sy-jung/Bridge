class PostingsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @postings = Posting.all
    end

    def show
      id = params[:id] # retrieve user ID from URI route
      @posting = Posting.find(id) # look up posting by unique ID
      # will render app/views/users/show.<extension> by default
    end

    def new
      @posting = Posting.new
    end

    def create
        @posting = Posting.new(posting_params)
        if @posting.save
            redirect_to @posting
        else
            render 'new'
        end
    end

    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def posting__params
      params.require(:posting).permit(:description, :price, :availability)
    end
  end
