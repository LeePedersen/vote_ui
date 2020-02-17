class RepliesController < ApplicationController

  before_action :authorize, only: [:new, :create]

  def index
    @post = Post.find(params[:post_id])
    @replies = @post.replies.all
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    render :index
  end
  #
  # def new
  #   @post = Post.new
  #   @user = User.find(session[:user_id])
  #   render :new
  # end
  #
  # def create
  #   @post = Post.new(post_params)
  #   if @post.save
  #     flash[:notice] = "You have posted your message"
  #     redirect_to posts_path
  #   else
  #     flash[:alert] = "Message not posted"
  #     render :new
  #   end
  # end
  #
  # def edit
  #   @post = Post.find(params[:id])
  #   if authorize_author(@post)
  #     @user = User.find(session[:user_id])
  #     render :edit
  #   end
  # end
  #
  # def show
  #   @post = Post.find(params[:id])
  #   if session[:user_id]
  #     @user = User.find(session[:user_id])
  #   end
  #   render :show
  # end
  #
  # def update
  #   @post= Post.find(params[:id])
  #   if authorize_author(@post)
  #     if @post.update(post_params)
  #       redirect_to posts_path
  #     else
  #     render :edit
  #     end
  #   end
  # end
  #
  # def destroy
  #   @post = Post.find(params[:id])
  #   binding.pry
  #   authorize_author(@post)
  #   @post.destroy
  #   redirect_to posts_path
  # end

  private
  def reply_params
    params.require(:reply).permit(:title, :content, :name, :post_id)
  end

end
