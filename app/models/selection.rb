class Selection < ApplicationRecord
  belongs_to :answer, inverse_of: :selections
  belongs_to :option, optional: true
  has_one :question, through: :option
  validates :option_id, :uniqueness => {scope: :answer_id}


end
