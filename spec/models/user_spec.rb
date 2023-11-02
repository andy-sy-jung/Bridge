# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(email: 'test@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is not valid without a first name' do
    user = User.new(email: nil)
    expect(user).not_to be_valid
  end

  # Add more tests for each field...
end
