# == Schema Information
#
# Table name: task_watches
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_task_watches_on_task_id  (task_id)
#  index_task_watches_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :task_watch do
    user
    task
  end
end
