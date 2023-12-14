# spec/channels/application_cable/channel_spec.rb

require 'rails_helper'

RSpec.describe ApplicationCable::Channel, type: :channel do
  let(:user) { create(:user) } # Adjust this according to your user model or authentication setup

  it 'successfully subscribes' do
    subscribe
    expect(subscription).to be_confirmed
  end

end
