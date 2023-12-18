require 'rails_helper'

RSpec.describe PostingsController, type: :controller do
  before do
    @user = User.create(email: 'user@example.com', password: 'password123') # Create a user
    @user2 = User.create(email: 'user2@example.com', password: 'password123')
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

  describe 'PATCH #update' do
    let(:posting) { Posting.create(
      user_id: @user.id,
      type_of: 'User',
      name: 'Test Name',
      price: 100.0,
      subject: 'CS',
      description: 'Test Description',
      availability: 'Available',
      contact: 'test@example.com'
    )}
    let(:valid_params) { { type_of: 'Professional', subject: 'Math', description: 'Updated description' } }
    let(:invalid_params) { { type_of: 'Professional', subject: '', description: 'Updated description' } }

    context 'with valid params' do
      it 'updates the posting' do
        patch :update, params: { id: posting.id, posting: valid_params }
        posting.reload

        expect(response).to redirect_to(posting_path(posting))
        expect(posting.type_of).to eq('Professional')
        expect(posting.subject).to eq('Math')
        expect(posting.description).to eq('Updated description')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:posting) do
      Posting.create(
        user_id: @user.id,
        type_of: 'User',
        name: 'Test Name',
        price: 100.0,
        subject: 'CS',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )
    end

    it 'deletes the posting' do
      puts "Count before deletion: #{Posting.count}"
      expect {
        delete :destroy, params: { id: posting.id }
      }.to change(Posting, :count).by(-1)
      puts "Count after deletion: #{Posting.count}"
    
      expect(response).to redirect_to(postings_path)
    end

    it 'redirects to postings_path' do
      delete :destroy, params: { id: posting.id }
      expect(response).to redirect_to(postings_path)
    end
  end

  describe 'GET #my_postings' do
    let!(:posting1) do
      Posting.create(
        user_id: @user.id,
        type_of: 'User',
        name: 'Test Name1',
        price: 100.0,
        subject: 'Math',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )
    end
    let!(:posting2) do
      Posting.create(
        user_id: @user.id,
        type_of: 'User',
        name: 'Test Name2',
        price: 100.0,
        subject: 'CS',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )
    end
    let!(:posting3) do
      Posting.create(
        user_id: @user2.id,
        type_of: 'User',
        name: 'Test Name3',
        price: 100.0,
        subject: 'CS',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )
    end


    it 'assigns @my_postings with postings belonging to the current user' do
      get :my_postings
      expect(assigns(:my_postings)).to match_array([posting1, posting2])
    end

    it 'renders the my_postings template' do
      get :my_postings
      expect(response).to render_template(:my_postings)
    end
  end

  describe 'GET #edit' do
    let!(:posting) do
      Posting.create(
        user_id: @user.id,
        type_of: 'User',
        name: 'Test Name3',
        price: 100.0,
        subject: 'CS',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )
    end

    it 'assigns the requested posting to @posting' do
      get :edit, params: { id: posting.id }
      expect(assigns(:posting)).to eq(posting)
    end

    it 'renders the edit template' do
      get :edit, params: { id: posting.id }
      expect(response).to render_template(:edit)
    end
  end


end
