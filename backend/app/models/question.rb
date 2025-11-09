# app/models/question.rb
class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices, dependent: :destroy

  validates :content, presence: true
end
