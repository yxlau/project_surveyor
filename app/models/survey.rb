class Survey < ApplicationRecord
  has_many :questions
  has_many :options, through: :questions
  validates :title, :description, presence: true
end
