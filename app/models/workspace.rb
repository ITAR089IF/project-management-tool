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

class Workspace < ApplicationRecord
  has_many :projects
  belongs_to :user

  validates :name, presence: true, length: { maximum: 30 }
end
