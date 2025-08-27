class ChaptersController < ApplicationController
  before_action :authenticate_author!
  before_action :set_book
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, except: [:show]

  def index
    @chapters = @book.chapters
  end

  def show
  end

  def new
    @chapter = @book.chapters.new
  end

  def create
    @chapter = @book.chapters.new(chapter_params)
    @chapter.author = current_author
    if @chapter.save
      redirect_to [@book, @chapter], notice: "Chapter created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @chapter.update(chapter_params)
      redirect_to [@book, @chapter], notice: "Chapter updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @chapter.destroy
    redirect_to book_path(@book), notice: "Chapter deleted successfully."
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_chapter
    @chapter = @book.chapters.find(params[:id])
  end

  def authorize_owner!
    return if action_name == 'show'
    redirect_to book_path(@book), alert: "Not authorized" unless @book.author == current_author
  end

  def chapter_params
    params.require(:chapter).permit(:title, :body, :position)
  end
end

