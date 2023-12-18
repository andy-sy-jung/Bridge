require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        # Mocking an authenticated user
        allow(controller).to receive(:authenticate_user!).and_return(true)
      end

      it 'redirects to postings_path' do
        get :index
        expect(response).to redirect_to(postings_path)
      end
    end

  end
end
