# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  body             :string
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint(8)
#  user_id          :bigint(8)
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_user_id                              (user_id)
#

FactoryBot.define do
  factory :comment, class: 'Comment' do
    body { Faker::Lorem.paragraph }
    association :user

    trait :for_task do
      association :commentable, factory: :task
    end

    trait :for_project do
      association :commentable, factory: :project
    end

  end
end
