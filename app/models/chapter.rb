class Chapter < ApplicationRecord
  belongs_to :book
  belongs_to :author

  validates :title, presence: true
  validates :body, presence: true
  validates :position, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  default_scope { order(position: :asc, created_at: :asc) }
end


