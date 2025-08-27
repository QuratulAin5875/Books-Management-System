class BooksController < ApplicationController
   before_action :authenticate_author!, except: [:all_books]

  def index
    puts "current_user", current_author.id
    @books = Book.where(author_id: current_author.id)
  end

  def show
    @book = Book.find(params[:id])
  end

  def about
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


  def all_books
    @page = (params[:page] || 1).to_i
    @per_page = 6
    @total_books = Book.count
    @total_pages = (@total_books.to_f / @per_page).ceil
    @books = Book.includes(:author).offset((@page - 1) * @per_page).limit(@per_page)
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
