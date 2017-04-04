class Answer < ApplicationRecord
  belongs_to :response, inverse_of: :answers
  belongs_to :question

  has_many :selections, inverse_of: :answer, dependent: :destroy

  has_one :single, class_name: 'Selection', foreign_key: :answer_id, inverse_of: :answer, dependent: :destroy

  has_one :option, through: :single, source: :option
  has_many :options, through: :selections

  accepts_nested_attributes_for :single, reject_if: :all_blank

  # before_save :mark_for_destroy

  validates :single, presence: { if: :single_required?}
  # validates_presence_of :options, if: :is_multi?
  validates_presence_of :option_ids, if: :is_multi?
  # validates_associated :multis











  def single_required?
    self.question.required && ! self.question.multi
  end

  def is_multi?
    self.question.multi && self.question.required
  end

  def unnecessary?
    ! self.question.required && self.option.blank?
  end








end
