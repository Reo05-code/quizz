# spec/models/question_spec.rb
require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { should belong_to(:quiz) }
    it { should have_many(:choices).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    # belongs_to quiz is required by default
  end
end
