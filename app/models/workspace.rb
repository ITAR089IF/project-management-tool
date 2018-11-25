# == Schema Information
#
# Table name: workspaces
#
#  id         :bigint(8)        not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_workspaces_on_deleted_at  (deleted_at)
#  index_workspaces_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Workspace < ApplicationRecord
  acts_as_paranoid
  belongs_to :user, required: true
  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects
  has_many :shared_workspaces
  has_many :members, through: :shared_workspaces, source: :user

  scope :order_asc, -> { order(id: :asc) }
  scope :search_workspaces, -> (search) { select('workspaces.id, workspaces.name').where("name ILIKE ?", "%#{search}%").order(name: :asc).limit(10) }

  validates :name, presence: true, length: { maximum: 250 }

  def all_members
    members.union(User.where(id: self.user_id))
  end

  def potential_members
    ids = [self.user_id]
    ids += self.members.ids
    User.where.not(id: ids)
  end
end
