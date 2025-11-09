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
      # spec/models/answer_spec.rb
require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'アソシエーション' do
    it '挑戦者に属すること' do
      should belong_to(:challenger)
    end
    it '選択肢に属すること' do
      should belong_to(:choice)
    end
  end

  describe 'バリデーション' do
    # Rails 5以降、belongs_toの関連付けはデフォルトで必須
  end

  describe '一意性のバリデーション' do
    let(:challenger) { Challenger.create!(name: 'テストユーザー', score: 0) }
    let(:quiz) { Quiz.create!(title: 'テストクイズ', author: 'テスト作成者') }
    let(:question) { quiz.questions.create!(content: 'テスト問題') }
    let(:choice) { question.choices.create!(content: 'テスト選択肢', correct_answer: true) }

    it '同じ挑戦者が同じ選択肢に複数回回答できないこと' do
      challenger.answers.create!(choice:)
      duplicate_answer = challenger.answers.build(choice:)
      expect(duplicate_answer).not_to be_valid
    end
  end
end
    end
  end
end
