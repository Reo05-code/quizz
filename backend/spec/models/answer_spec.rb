# spec/models/answer_spec.rb
require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { should belong_to(:challenger) }
    it { should belong_to(:choice) }
  end

  describe 'validations' do
    # belongs_to associations are required by default in Rails 5+
  end

  describe 'uniqueness validation' do
    let(:challenger) { Challenger.create!(name: 'Test User', score: 0) }
    let(:quiz) { Quiz.create!(title: 'Test Quiz', author: 'Test Author') }
    let(:question) { quiz.questions.create!(content: 'Test Question') }
    let(:choice) { question.choices.create!(content: 'Test Choice', correct_answer: true) }

    it 'does not allow duplicate answers for the same challenger and choice' do
      Answer.create!(challenger: challenger, choice: choice)
      duplicate = Answer.new(challenger: challenger, choice: choice)
      expect(duplicate).not_to be_valid
    end
  end
end
