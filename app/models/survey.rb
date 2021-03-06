class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :options, through: :questions
  has_many :responses, dependent: :destroy
  has_many :answers, through: :responses
  has_many :selections, through: :answers
  validates :title, :description, presence: true
end
