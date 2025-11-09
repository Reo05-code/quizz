# spec/models/choice_spec.rb
require 'rails_helper'

RSpec.describe Choice, type: :model do
  describe 'associations' do
    it { should belong_to(:question) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:challengers).through(:answers) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    # belongs_to question is required by default
  end
end
