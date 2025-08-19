# app/mailers/book_creation_mailer.rb
class BookCreationMailer < ApplicationMailer
    default from: "testeremail.com@yopmail.com"
  def book_created_email(book)
    @book = book
    @author = book.author
    mail(to: "book1mail@yopmail.com", subject: "Your New Book '#{@book.title}' Has Been Created!")
  end
end