class Project < ApplicationRecord
  include ImageUploader::Attachment.new(:landscape)
  include ImageUploader::Attachment.new(:thumbnail)
  include Aasm::Project

  belongs_to :category, optional: true
  has_many :contributions
  has_many :contributors, through: :contributions, source: :user
  has_many :counterparts, dependent: :destroy

  validates :name, :target_amount, presence: true
  validates :target_amount, numericality: { greater_than: 0, only_integer: true }

  def percentage_of_completion
    amount_invested * 100 / target_amount
  end

  def amount_invested
    contributions.pluck(:amount).sum
  end
end
