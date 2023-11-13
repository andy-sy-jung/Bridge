class PostingsController < ApplicationController

    attr_accessor :all_types
    attr_accessor :types_to_show

    before_action :authenticate_user!
    before_action :init

    def init
      @all_types = Posting.all_types
      @types_to_show = ''
    end
    
    def index
      update_types_to_show
        @postings = Posting.with_types(@types_to_show)
    end

    def update_types_to_show
      if params[:types].nil?
        @types_to_show = Posting.all_types
      else
        @types_to_show = params[:types].keys.map(&:to_s)
      end
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
