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
