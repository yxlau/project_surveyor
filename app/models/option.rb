class Option < ApplicationRecord
  belongs_to :question, inverse_of: :options
  has_one :survey, through: :question
  has_many :selections, inverse_of: :option
  has_many :answers, through: :selections
  validates :value, presence: true, if: :last_step?

  def last_step?
    self.question.last_step?
  end
end
