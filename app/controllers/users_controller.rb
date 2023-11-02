class UsersController < ApplicationController
    before_action :authenticate_user!
    def index
        redirect_to postings_path
    end
end
