require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do

  describe 'email sending' do
    let(:user) { create(:user, email: 'user@example.com') }

  end
end
