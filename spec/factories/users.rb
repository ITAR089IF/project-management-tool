FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |index| Faker::Internet.email.sub(/\@/, "_#{index}@") }
    password { Faker::Internet.password }
    role { Faker::Job.title }
    department { Faker::Job.field }
    about { Faker::Lorem.sentences }
  end
end
