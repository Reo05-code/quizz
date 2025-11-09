# spec/models/quiz_spec.rb
require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe 'associations' do
    it { should have_many(:questions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_length_of(:title).is_at_most(255) }
    it { should validate_length_of(:author).is_at_most(255) }
  end

  describe 'creating a quiz' do
    it 'is valid with valid attributes' do
      quiz = Quiz.new(title: 'Test Quiz', author: 'Test Author')
      expect(quiz).to be_valid
    end

    it 'is not valid without a title' do
      quiz = Quiz.new(author: 'Test Author')
      expect(quiz).not_to be_valid
    end

    it 'is not valid without an author' do
      quiz = Quiz.new(title: 'Test Quiz')
      expect(quiz).not_to be_valid
    end
  end
end
