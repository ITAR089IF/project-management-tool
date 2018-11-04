FactoryBot.define do
  factory :project do
    name { Faker::App.name }

    workspace
  end
end
