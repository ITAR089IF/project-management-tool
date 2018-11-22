# == Schema Information
#
# Table name: messages
#
#  id               :bigint(8)        not null, primary key
#  body             :text
#  is_read          :boolean          default(FALSE)
#  messageable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  messageable_id   :bigint(8)
#  user_id          :bigint(8)
#
# Indexes
#
#  index_messages_on_messageable_type_and_messageable_id  (messageable_type,messageable_id)
#  index_messages_on_user_id                              (user_id)
#  index_messages_on_user_id_and_is_read                  (user_id,is_read)
#

require 'rails_helper'

RSpec.describe Message, type: :model do

  context 'factory' do
    it { expect(build(:message)).to be_valid }
  end
end
