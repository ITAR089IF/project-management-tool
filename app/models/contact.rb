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

class Contact < ApplicationRecord
  validates :name, :phone, presence: true
  validates :message, length: { maximum: 3000 }, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, presence: true
end
