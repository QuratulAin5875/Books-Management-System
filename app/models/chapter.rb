class Chapter < ApplicationRecord
  belongs_to :book
  belongs_to :author
  validates :title, presence: true
end

