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

  describe '#update_types_to_show' do
    it 'sets @types_to_show to all types if params[:types] is nil' do
      controller.params[:types] = nil

      controller.send(:update_types_to_show)

      expect(controller.instance_variable_get(:@types_to_show)).to eq(Posting.all_types)
    end

    it 'sets @types_to_show to params[:types] keys as strings' do
      controller.params[:types] = { type1: '1', type2: '1' }

      controller.send(:update_types_to_show)

      expect(controller.instance_variable_get(:@types_to_show)).to eq(['type1', 'type2'])
    end
  end

  describe '#update_subjects_to_show' do
    it 'sets @subjects_to_show to all subjects if params[:subjects] is nil' do
      controller.params[:subjects] = nil

      controller.send(:update_subjects_to_show)

      expect(controller.instance_variable_get(:@subjects_to_show)).to eq(Posting.all_subjects)
    end

    it 'sets @subjects_to_show to params[:subjects] keys as strings' do
      controller.params[:subjects] = { subject1: '1', subject2: '1' }

      controller.send(:update_subjects_to_show)

      expect(controller.instance_variable_get(:@subjects_to_show)).to eq(['subject1', 'subject2'])
    end
  end



end
