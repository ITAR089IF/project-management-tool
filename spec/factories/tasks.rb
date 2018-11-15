# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  complete    :boolean          default(FALSE)
#  deleted_at  :datetime
#  description :text
#  due_date    :datetime
#  row_order   :integer
#  section     :boolean
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  assignee_id :bigint(8)
#  project_id  :bigint(8)
#
# Indexes
#
#  index_tasks_on_assignee_id  (assignee_id)
#  index_tasks_on_deleted_at   (deleted_at)
#  index_tasks_on_project_id   (project_id)
#  index_tasks_on_row_order    (row_order)
#
# Foreign Keys
#
#  fk_rails_...  (assignee_id => users.id)
#  fk_rails_...  (project_id => projects.id)
#

FactoryBot.define do
  factory :task, class: 'Task' do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    project

    trait :completed do
      complete { true }
    end

    trait :with_files do
      transient do
        files_count { 3 }
      end

      after(:build) do |task, evaluator|
        evaluator.files_count.times do
          task.files.attach(FileFactory.random_file)
        end
      end
    end

    trait :expired do 
      due_date { Faker::Date.backward(30) }
    end

    trait :future do 
      due_date { Faker::Date.forward(30) }
    end
  end
end
