class Selection < ApplicationRecord
  belongs_to :answer, inverse_of: :selections
  belongs_to :option
  has_one :question, through: :option
  validates :option_id, :uniqueness => {scope: :answer_id}


  def is_required?
    self.option.question.required unless self.option.blank?
  end

  def rejection
    fjdksfajkl
  end
end
