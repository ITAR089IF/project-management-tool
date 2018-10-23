# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  row_order   :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_row_order   (row_order)
#

FactoryBot.define do
  factory :task, class: 'Task' do
    title { Faker::Name.first_name }
    description { Faker::Lorem.paragraph }
  end
end
