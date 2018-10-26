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

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
