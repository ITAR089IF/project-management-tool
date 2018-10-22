# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  row_order   :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer
#

class Task < ApplicationRecord
  include RankedModel

  belongs_to :project

  validates :title, length: { maximum: 250 }, presence: true
  validates :description, length: { maximum: 250 }, presence: true

  ranks :row_order, with_same: :project_id
end
