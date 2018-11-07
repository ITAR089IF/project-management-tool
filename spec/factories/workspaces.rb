# == Schema Information
#
# Table name: workspaces
#
#  id         :bigint(8)        not null, primary key
<<<<<<< HEAD
=======
#  deleted_at :datetime
>>>>>>> b092eacb5818dd9cedd90bd40fa2668888cd3732
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
<<<<<<< HEAD
#  index_workspaces_on_user_id  (user_id)
=======
#  index_workspaces_on_deleted_at  (deleted_at)
#  index_workspaces_on_user_id     (user_id)
>>>>>>> b092eacb5818dd9cedd90bd40fa2668888cd3732
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :workspace do
    name { Faker::Job.field }

    user
  end
end
