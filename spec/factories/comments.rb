# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  body             :string
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  user_id          :integer
#

FactoryBot.define do
  factory :project_comment, class: 'Comment' do
    body { Faker::Lorem.paragraph }
    association :user
    association :commentable, factory: :project
  end
end

FactoryBot.define do
  factory :task_comment, class: 'Comment' do
    body { Faker::Lorem.paragraph }
    association :user
    association :commentable, factory: :task
  end
end
