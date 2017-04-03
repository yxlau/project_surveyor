class Survey < ApplicationRecord
  has_many :questions
  has_many :options, through: :questions
  has_many :responses
  has_many :answers, through: :responses
  has_many :selections, through: :answers
  validates :title, :description, presence: true
end
