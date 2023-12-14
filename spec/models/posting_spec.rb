require 'rails_helper'

RSpec.describe Posting, type: :model do
  before do
    @user = User.create(email: 'user@example.com', password: 'password123') # Create a user
  end
  subject(:posting) { described_class.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:type_of) }
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:availability) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:contact) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '.with_categories' do
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
        type_of: 'Professional',
        name: 'Test Name2',
        price: 100.0,
        subject: 'CS',
        description: 'Test Description',
        availability: 'Available',
        contact: 'test@example.com'
      )
    end

    context 'when both types_list and subjects_list are empty or nil' do
      it 'returns all postings' do
        result = Posting.with_categories([], [])
        expect(result).to include(posting1, posting2)
      end
    end

    context 'when subjects_list is empty or nil' do
      it 'returns postings with matching types' do
        result = Posting.with_categories(['User'], [])
        expect(result).to include(posting1)
        expect(result).not_to include(posting2)
      end
    end

    context 'when types_list is empty or nil' do
      it 'returns postings with matching subjects' do
        result = Posting.with_categories([], ['Math'])
        expect(result).to include(posting1)
        expect(result).not_to include(posting2)
      end
    end

    context 'when both types_list and subjects_list are provided' do
      it 'returns postings with matching types and subjects' do
        result = Posting.with_categories(['User'], ['Math'])
        expect(result).to include(posting1)
        expect(result).not_to include(posting2)
      end
    end
  end
end
