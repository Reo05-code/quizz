# spec/models/choice_spec.rb
require 'rails_helper'

RSpec.describe Choice, type: :model do
  describe 'アソシエーション' do
    it '問題に属すること' do
      should belong_to(:question)
    end
    it '回答を複数持ち、削除時に依存する回答も削除されること' do
      should have_many(:answers).dependent(:destroy)
    end
    it '回答を通じて挑戦者を複数持つこと' do
      should have_many(:challengers).through(:answers)
    end
  end

  describe 'バリデーション' do
    it '内容が存在すること' do
      should validate_presence_of(:content)
    end
    # belongs_to :question はデフォルトで必須
  end
end
