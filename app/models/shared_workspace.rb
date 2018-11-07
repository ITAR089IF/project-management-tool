class SharedWorkspace < ApplicationRecord
  belongs_to :member, :class_name => 'User'
  belongs_to :invited_workspace, :class_name => 'Workspace'
end
