class BooksController < ApplicationController
  before_action :authenticate_author!, except: [:all_books]
def index
  # Use param if present, otherwise fallback to logged-in author
  author_id = params[:author_id] || current_author.id
  @author = Author.find(author_id)

  books_scope = @author.books
  @page = (params[:page] || 1).to_i
  per_page = 5
  @total_pages = (books_scope.count / per_page.to_f).ceil
  @books = books_scope.offset((@page - 1) * per_page).limit(per_page)
end


  def all_books
    @page = (params[:page] || 1).to_i
    @per_page = 5

    # Get total books
    @total_books = Book.count
    @total_pages = (@total_books.to_f / @per_page).ceil

    # Fetch paginated books
    @books = Book.includes(:author).offset((@page - 1) * @per_page).limit(@per_page)
  end

  def about
    @book = Book.find(params[:id])
  end

  def show
    @book = Book.find(params[:id])  
  end

  def new
    @book = current_author.books.new
  end

  def create
    @book = current_author.books.new(book_params)
    if @book.save
      BookCreationMailer.book_created_email(@book).deliver_now
      redirect_to @book, notice: "Book created successfully."
    else
      render :new
    end
  end

  def edit
    @book = current_author.books.find(params[:id])
  end

  def update
    @book = current_author.books.find(params[:id])
    if @book.update(book_params)
      redirect_to books_path, notice: "Book updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = current_author.books.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book deleted successfully."
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_name, :publisher, :published_date, :status, :about)
  end
end
