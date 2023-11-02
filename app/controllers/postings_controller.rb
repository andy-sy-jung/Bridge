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
      @posting.user = current_user # Associate the posting with the currently logged-in user
  
      if @posting.save
        redirect_to postings_path
      else
        render :new
      end
    end

    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def posting_params
      params.require(:posting).permit(:name, :description, :price, :availability, :subject, :availability, :contact, :type_of)
    end
  end
