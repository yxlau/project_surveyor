class Option < ApplicationRecord
  belongs_to :question, inverse_of: :options
  has_one :survey, through: :question
  validates :value, presence: true, if: :last_step?

  def last_step?
    self.question.last_step?
  end
end
