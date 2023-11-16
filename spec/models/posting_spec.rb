require 'rails_helper'

RSpec.describe Posting, type: :model do
  subject(:posting) { described_class.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:type_of) }
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:availability) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:contact) }
  end
end