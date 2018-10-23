FactoryBot.define do
  factory :project do
    name { Faker::Name.last_name }
  end
end
