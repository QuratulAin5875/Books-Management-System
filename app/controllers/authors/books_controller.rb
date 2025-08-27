class Authors::BooksController < ApplicationController
  before_action :authenticate_author!

  def index
    @page = (params[:page] || 1).to_i
    @per_page = 6
    books_scope = current_author.books
    @total_pages = (books_scope.count / @per_page.to_f).ceil
    @books = books_scope.offset((@page - 1) * @per_page).limit(@per_page)
    render "books/index"
  end
end
