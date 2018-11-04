class Task < ApplicationRecord
  include RankedModel
  include Commentable

  ranks :row_order, with_same: :project_id

  belongs_to :project, required: true

  scope :row_order_asc, -> { order(row_order: :asc) }

  validates :title, length: { maximum: 250 }, presence: true
  validates :description, length: { maximum: 250 }

end
