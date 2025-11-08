# app/models/challenger.rb
class Challenger < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :choices, through: :answers

  validates :name, presence: true, length: { maximum: 255 }
  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
