class Workspace < ApplicationRecord
  belongs_to :user, required: true
  has_many :projects, dependent: :destroy

  scope :order_desc, -> { order(id: :desc) }

  validates :name, presence: true, length: { maximum: 30 }
end
