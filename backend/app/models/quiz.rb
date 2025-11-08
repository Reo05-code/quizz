# app/models/quiz.rb
class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :author, presence: true, length: { maximum: 255 }
end
