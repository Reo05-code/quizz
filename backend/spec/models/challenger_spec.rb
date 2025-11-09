# spec/models/challenger_spec.rb
require 'rails_helper'

RSpec.describe Challenger, type: :model do
  describe 'associations' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:choices).through(:answers) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:score) }
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_numericality_of(:score).only_integer.is_greater_than_or_equal_to(0) }
  end
end
