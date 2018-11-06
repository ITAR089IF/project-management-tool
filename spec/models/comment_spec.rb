# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  body             :string
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint(8)
#  user_id          :bigint(8)
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_user_id                              (user_id)
#

require 'rails_helper'

RSpec.describe Comment, type: :model do

  context 'factories' do
  it { expect(build(:comment, :for_project)).to be_valid }
  it { expect(build(:comment, :for_task)).to be_valid }
  end
end
