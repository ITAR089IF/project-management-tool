# == Schema Information
#
# Table name: workspaces
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_workspaces_on_user_id  (user_id)
#

class Workspace < ApplicationRecord
  has_many :projects, dependent: :delete_all
  belongs_to :user, required: true

  validates :name, presence: true, length: { maximum: 30 }

  scope :order_desc, -> { order(id: :desc) }
end
