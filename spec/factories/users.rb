FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |index| Faker::Internet.email.sub(/\@/, "#{index}_@") }
    password { Faker::Internet.password }
  end
end
