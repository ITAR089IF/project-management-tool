FactoryBot.define do
  factory :task do
    title { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    association :project
  end
end
