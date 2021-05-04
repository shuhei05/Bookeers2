class BookCommentsController < ApplicationController
    
  def create
      @book = Book.find(params[:book_id]) #コメントする投稿ID
      comment = BookComment.new(book_comment_params)
      comment.user_id = current_user.id
      comment.book_id = @book.id #数字がわかるようにidを記述。なくても作動するがわかりやすくするため。
      comment.save
  end

  def destroy
    
    BookComment.find_by(id: params[:id],book_id: params[:book_id]).destroy
    @book = Book.find(params[:book_id])

  end
  
   private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
