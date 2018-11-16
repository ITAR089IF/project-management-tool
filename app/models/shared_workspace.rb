# == Schema Information
#
# Table name: shared_workspaces
#
#  id           :bigint(8)        not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint(8)
#  workspace_id :bigint(8)
#
# Indexes
#
#  index_shared_workspaces_on_user_id       (user_id)
#  index_shared_workspaces_on_workspace_id  (workspace_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (workspace_id => workspaces.id)
#

class SharedWorkspace < ApplicationRecord
  belongs_to :user
  belongs_to :workspace

  validates_uniqueness_of :user_id, scope: :workspace_id
end