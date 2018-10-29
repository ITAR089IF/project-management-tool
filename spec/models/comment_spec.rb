# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  body             :string
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  user_id          :integer
#
# Indexes
#
#  index_comments_on_commentable_id_and_commentable_type  (commentable_id,commentable_type)
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
end
