# spec/models/question_spec.rb
require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'アソシエーション' do
    it 'クイズに属すること' do
      should belong_to(:quiz)
    end
    it '選択肢を複数持ち、削除時に依存する選択肢も削除されること' do
      should have_many(:choices).dependent(:destroy)
    end
  end

  describe 'バリデーション' do
    it '内容が存在すること' do
      should validate_presence_of(:content)
    end
    # belongs_to :quiz はデフォルトで必須
  end
end
