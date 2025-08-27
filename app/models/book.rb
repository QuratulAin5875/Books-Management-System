class Book < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :chapters, dependent: :destroy
  after_create :send_book_creation_email

  private

  def send_book_creation_email
    BookCreationMailer.book_created_email(self).deliver_later
  end
end
