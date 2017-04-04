class Response < ApplicationRecord
  belongs_to :survey, counter_cache: true
  has_many :questions, through: :survey
  has_many :answers, inverse_of: :response
  has_many :selections, through: :answers
  has_many :singles, through: :answers, source: :single
  accepts_nested_attributes_for :answers
  validates_associated :answers



end
