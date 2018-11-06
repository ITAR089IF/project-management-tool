FactoryBot.define do
  factory :workspace do
    name { Faker::Job.field }

    user
  end
end
