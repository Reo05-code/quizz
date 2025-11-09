# app/models/choice.rb
class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers, dependent: :destroy
  has_many :challengers, through: :answers

  validates :content, presence: true
  validates :correct_answer, inclusion: { in: [true, false] }
end
