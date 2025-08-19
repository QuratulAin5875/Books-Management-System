class Book < ApplicationRecord
  belongs_to :author
  after_create :send_book_creation_email

  private

  def send_book_creation_email
    BookCreationMailer.book_created_email(self).deliver_later
  end
end
