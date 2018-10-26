# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  description :text
#  section_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ApplicationRecord
  include RankedModel

  belongs_to :project
  has_many :comments, as: :commentable

  validates :title, length: { maximum: 250 }, presence: true
  validates :description, length: { maximum: 250 }, presence: true

  ranks :row_order, with_same: :section_id
  paginates_per  5
end
