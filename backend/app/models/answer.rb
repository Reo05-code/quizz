# app/models/answer.rb
class Answer < ApplicationRecord
  belongs_to :challenger
  belongs_to :choice

  validates :challenger_id, uniqueness: { scope: :choice_id }
end
