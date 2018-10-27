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

  scope :order_desc, -> { order(id: :desc) }

  validates :body, length: { maximum: 250 }, presence: true
  validates :commentable_id, :user_id, presence: true
  validates :commentable_type, inclusion: { in: %w(Task Project) }
end
