# == Schema Information
#
# Table name: workspaces
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_workspaces_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Workspace < ApplicationRecord
  scope :order_desc, -> { order(id: :desc) }

  belongs_to :user, required: true
  has_many :projects

  validates :name, presence: true, length: { maximum: 30 }
end
