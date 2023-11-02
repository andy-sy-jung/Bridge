require 'rails_helper'

RSpec.describe PostingsController, type: :controller do
  before do
    @user = User.create(email: 'user@example.com', password: 'password123') # Create a user
    sign_in @user # Sign in the user using Devise
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @postings with all postings' do
      posting = Posting.create(
        user_id: @user.id,
        type_of: 'Professional',
        name: 'Test Name',
        price: 100.0,
        subject: 'Test Subject',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )

      get :index
      expect(assigns(:postings)).to include(posting)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      posting = Posting.create(
        user_id: @user.id,
        type_of: 'Professional',
        name: 'Test Name',
        price: 100.0,
        subject: 'Test Subject',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )

      get :show, params: { id: posting.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the correct posting to @posting' do
      posting = Posting.create(
        user_id: @user.id,
        type_of: 'Professional',
        name: 'Test Name',
        price: 100.0,
        subject: 'Test Subject',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )

      get :show, params: { id: posting.id }
      expect(assigns(:posting)).to eq(posting)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new posting to @posting' do
      get :new
      expect(assigns(:posting)).to be_a_new(Posting)
    end
  end

  describe 'POST #create' do
    it 'creates a new posting' do
      posting_params = {
        user_id: @user.id,
        type_of: 'Professional',
        name: 'Test Name',
        price: 100.0,
        subject: 'Test Subject',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      }

      expect do
        post :create, params: { posting: posting_params }
      end.to change(Posting, :count).by(1)

      expect(response).to redirect_to(postings_path)
    end

    # need to add validation to adding new posting
    it 're-renders the new template if posting creation fails' do
      posting_params = { user_id: @user.id } # Incomplete posting data

      post :create, params: { posting: posting_params }
      expect(response).to render_template(:new)
    end
  end
end
