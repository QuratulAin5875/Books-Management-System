class Authors::BooksController < ApplicationController
  before_action :authenticate_author!

  def index
    # Reuse the same view as books#index
    @books = current_author.books
    render "books/index"
  end
end
