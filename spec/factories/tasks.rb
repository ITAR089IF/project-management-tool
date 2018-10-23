FactoryBot.define do
  factory :task, class: 'Task' do
    title { Faker::Name.first_name }
    description { Faker::Lorem.paragraph }
  end
end
