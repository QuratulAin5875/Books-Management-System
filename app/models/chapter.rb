class Chapter < ApplicationRecord
  belongs_to :book
  belongs_to :author
  validates :title, presence: true

  # Find the next chapter in the book
  def next_chapter
    book.chapters.where('id > ?', id).order(:id).first
  end

  # Find the previous chapter in the book
  def previous_chapter
    book.chapters.where('id < ?', id).order(:id).last
  end

  # Check if there's a next chapter
  def has_next?
    next_chapter.present?
  end

  # Check if there's a previous chapter
  def has_previous?
    previous_chapter.present?
  end
end

