class FacebooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_facebook, only: [:show, :edit, :update, :destroy]

  def index
    @facebooks = Facebook.all
    respond_to do |format|
    format.html
    format.js
  end
  end

  def show
    @comment = @facebook.comments.build
    @comments = @facebook.comments
     Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def new
    if params[:back]
      @facebook = Facebook.new(facebooks_params)
    else
      @facebook = Facebook.new
    end
  end

  def create
    @facebook = Facebook.new(facebooks_params)
    @facebook.user_id = current_user.id
    if @facebook.save
      redirect_to facebooks_path, notice: "トピックを作成しました！"
      NoticeMailer.sendmail_facebook(@facebook).deliver
    else
      render 'new'
    end
  end

  def edit
  #  @facebook = Facebook.find(params[:id])
   if @facebook.user != current_user
     redirect_to facebooks_path, notice: "作成者しか編集できません"
   end
  end

  def update
  #  @facebook = Facebook.find(params[:id])
  if @facebook.user != current_user
    redirect_to facebooks_path, notice: "作成者しか更新できません"
  else
    if @facebook.update(facebooks_params)
      redirect_to facebooks_path, notice: "トピックを更新しました！"
    else
      render 'edit'
    end
  end
  end

  def destroy
    if @facebook.user != current_user
      redirect_to facebooks_path, notice: "作成者しか削除できません"
    else
     @facebook.destroy
     redirect_to facebooks_path, notice: "トピックを削除しました！"
   end
  end

  def confirm
    @facebook = Facebook.new(facebooks_params)
    render :new if @facebook.invalid?
  end

  private
  def facebooks_params
    params.require(:facebook).permit(:title, :content, :image, :image_cache)
  end

  def set_facebook
    @facebook = Facebook.find(params[:id])
  end

end
