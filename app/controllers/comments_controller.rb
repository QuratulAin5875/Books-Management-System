class CommentsController < ApplicationController
  before_action :authenticate_author!   # ensure only authors can comment
  before_action :set_book
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @book.comments.build(comment_params)
    @comment.author = current_author
    @comment.email  = current_author.email

    if @comment.save
      redirect_to book_path(@book), notice: "Comment added!"
    else
      redirect_to book_path(@book), alert: "Could not add comment."
    end
  end

  def edit
    redirect_to book_path(@book), alert: "You can't edit this comment" unless owns_comment?
  end

  def update
    if owns_comment? && @comment.update(comment_params)
      redirect_to book_path(@book), notice: "Comment updated"
    else
      redirect_to book_path(@book), alert: "You can't update this comment"
    end
  end

  def destroy
    if owns_comment?
      @comment.destroy
      redirect_to book_path(@book), notice: "Comment deleted"
    else
      redirect_to book_path(@book), alert: "You can't delete this comment"
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_comment
    @comment = @book.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def owns_comment?
    @comment.author_id == current_author.id
  end
end
