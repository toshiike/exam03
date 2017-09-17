class FacebooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_facebook, only: [:edit, :update, :destroy]

  def index
    @facebooks = Facebook.all
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
  end

  def update
  #  @facebook = Facebook.find(params[:id])
    if @facebook.update(facebooks_params)
      redirect_to facebooks_path, notice: "トピックを更新しました！"
    else
      render 'edit'
    end
  end

  def destroy
  #  @facebook = Facebook.find(params[:id])
    @facebook.destroy
    redirect_to facebooks_path, notice: "トピックを削除しました！"
  end

  def confirm
    @facebook = Facebook.new(facebooks_params)
    render :new if @facebook.invalid?
  end

  private
  def facebooks_params
    params.require(:facebook).permit(:title, :content)
  end

  def set_facebook
    @facebook = Facebook.find(params[:id])
  end

end