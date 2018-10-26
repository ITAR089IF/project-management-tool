# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  row_order   :integer
#  section     :boolean
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint(8)
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_row_order   (row_order)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#

class Task < ApplicationRecord
  include RankedModel

  ranks :row_order, with_same: :project_id

  belongs_to :project, required: true

  scope :row_order_asc, -> { order(row_order: :asc) }

  validates :title, length: { maximum: 250 }, presence: true
  validates :description, length: { maximum: 250 }

  before_save :section

  def section
    self.section = /[:]$/.match?(self.title.strip) ? true : false
  end
end
