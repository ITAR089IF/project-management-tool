# == Schema Information
#
# Table name: contacts
#
#  id         :bigint(8)        not null, primary key
#  email      :string
#  message    :text
#  name       :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :contact, class: Contact do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    message { Faker::Lorem.paragraph }
  end
end
