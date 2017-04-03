class Answer < ApplicationRecord
  belongs_to :response, inverse_of: :answers
  belongs_to :question

  has_many :selections

  has_one :single, class_name: 'Selection', foreign_key: :answer_id, inverse_of: :answer, dependent: :destroy

  has_many :multis, class_name: 'Selection', foreign_key: :answer_id, dependent: :destroy, inverse_of: :answer

  has_one :option, through: :single, source: :option
  has_many :options, through: :multis, source: :option

  accepts_nested_attributes_for :single, allow_destroy: true

  before_validation :mark_for_destroy

  validates_presence_of :single, unless: :single_required?
  validates_presence_of :options, if: :is_multi?
  # validates_presence_of :option_ids, if: :is_multi?
  validates_associated :multis






  def is_required?
    self.option.question.required
  end

  def single_required?
    self.question.required
  end

  def is_multi?
    self.question.multi && self.question.required
  end

  def unnecessary?
    ! self.question.required && self.option.blank?
  end








end
