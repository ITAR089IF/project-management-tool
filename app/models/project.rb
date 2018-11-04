class Project < ApplicationRecord
  include Commentable
  belongs_to :workspace, required: true
  has_many :tasks, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects

  scope :order_desc, -> { order(id: :desc) }

  validates :name, length: { maximum: 250 }, presence: true
end
