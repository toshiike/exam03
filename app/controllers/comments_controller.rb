class CommentsController < ApplicationController
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @facebook = @comment.facebook
    @notification = @comment.notifications.build(user_id: @facebook.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to facebook_path(@facebook), notice: 'コメントを投稿しました。' }
        format.js { render :index }
        unless @comment.facebook.user_id == current_user.id
          Pusher.trigger("user_#{@comment.facebook.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
          })
        end
        Pusher.trigger("user_#{@comment.facebook.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.facebook.user.id, read: false).count
        })
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @facebook = @comment.facebook_id
    respond_to do |format|
      @comment.destroy
      format.html { redirect_to facebook_path(@facebook), notice: 'コメントを削除しました。' }
      format.js { render :index }
      end
  end

  def edit
    @comment = Comment.find(params[:id])
    @facebook = @comment.facebook
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to facebook_path(@comment.facebook), notice: 'コメントを更新しました。'
    else
      render 'edit'
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:facebook_id, :content)
    end
end
