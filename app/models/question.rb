class Question < ApplicationRecord
  attr_accessor :current_step
  belongs_to :survey
  has_many :options, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :options
  validates :option_count, presence: true, numericality: {only_integer: true, greater_than: 0}, if: :first_step?
  validates :multi, :required, inclusion: {in: [true, false], message: "Must select one"}, if: :first_step?
  validates :required, inclusion: {in: [true, false], message: "Must select one"}, if: :first_step?
  validates :title, presence: true, if: :last_step?
  validates_associated :options


  def steps
    %w[select add]
  end

  def first_step?
    current_step == steps.first
  end

  def current_step
    @current_step || steps.first
  end

  def next_step
    steps.last
  end

  def back
    steps.first
  end

  def last_step?
    current_step == steps.last
  end


  def all_valid?
    steps.all? do |s|
      self.current_step = s
      valid?
    end
  end

end
