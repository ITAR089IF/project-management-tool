# == Schema Information
#
# Table name: authentication_tokens
#
#  id           :bigint(8)        not null, primary key
#  body         :string
#  expires_in   :integer
#  ip_address   :string
#  last_used_at :datetime
#  user_agent   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint(8)
#
# Indexes
#
#  index_authentication_tokens_on_body     (body)
#  index_authentication_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe AuthenticationToken, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
