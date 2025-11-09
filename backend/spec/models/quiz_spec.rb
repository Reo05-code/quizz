# spec/models/quiz_spec.rb
require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe 'アソシエーション' do
    it '問題を複数持ち、削除時に依存する問題も削除されること' do
      should have_many(:questions).dependent(:destroy)
    end
  end

  describe 'バリデーション' do
    it 'タイトルが存在する' do
      should validate_presence_of(:title)
    end

    it '作成者が存在する' do
      should validate_presence_of(:author)
    end

    it 'タイトルが255文字以内であること' do
      should validate_length_of(:title).is_at_most(255)
    end

    it '作成者名が255文字以内であること' do
      should validate_length_of(:author).is_at_most(255)
    end
  end

  describe 'クイズ作成のテスト' do
    it '有効な属性を持つクイズは有効であること' do
      quiz = Quiz.new(title: 'テストクイズ', author: 'テスト作成者')
      expect(quiz).to be_valid
    end

    it 'タイトルがない場合は無効であること' do
      quiz = Quiz.new(author: 'テスト作成者')
      expect(quiz).not_to be_valid
    end

    it '作成者がない場合は無効であること' do
      quiz = Quiz.new(title: 'テストクイズ')
      expect(quiz).not_to be_valid
    end
  end
end
