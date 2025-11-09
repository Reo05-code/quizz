# spec/models/challenger_spec.rb
require 'rails_helper'

RSpec.describe Challenger, type: :model do
  describe 'アソシエーション' do
    it '回答を複数持ち、削除時に依存する回答も削除されること' do
      should have_many(:answers).dependent(:destroy)
    end
    it '回答を通じて選択肢を複数持つこと' do
      should have_many(:choices).through(:answers)
    end
  end

  describe 'バリデーション' do
    it '名前が存在すること' do
      should validate_presence_of(:name)
    end

    it 'スコアが存在すること' do
      should validate_presence_of(:score)
    end

    it '名前が255文字以内であること' do
      should validate_length_of(:name).is_at_most(255)
    end

    it 'スコアが0以上の整数であること' do
      should validate_numericality_of(:score).only_integer.is_greater_than_or_equal_to(0)
    end
  end
end
