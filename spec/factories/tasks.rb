# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  row_order   :integer
#  section     :boolean          default(FALSE)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint(8)
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_row_order   (row_order)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#

FactoryBot.define do
  factory :task, class: 'Task' do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }

    project

    trait :with_files do
      after(:build) do |user|
        2.times do |n|
          file = ["image1.jpg", "image2.jpg", "asana.png", "text.txt", "book.pdf"].sample
          user.files.attach(io: File.open(Rails.root.join('spec', 'factories', 'files', file)), filename: file)
        end
      end
    end
  end
end
