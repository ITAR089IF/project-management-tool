FactoryBot.define do
  factory :workspace do
    name { Faker::Name.first_name }
  end
end
