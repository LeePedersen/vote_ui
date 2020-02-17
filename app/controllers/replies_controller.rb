class RepliesController < ApplicationController

  before_action :authorize, only: [:new, :create]

  before_action do
    @post = Post.find(params[:post_id])
  end

  def index
    @replies = @post.replies.all
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    render :index
  end

  def new
    @reply = @post.replies.new
    @user = User.find(session[:user_id])
    render :new
  end

  def create
    @reply = @post.replies.new(reply_params)
    if @reply.save
      flash[:notice] = "You have posted your reply"
      redirect_to posts_path
    else
      flash[:alert] = "Message not posted"
      render :new
    end
  end

  def edit
    @reply = @post.replies.find(params[:id])
    if authorize_author(@reply)
      @user = User.find(session[:user_id])
      render :edit
    end
  end

  def show
    @reply = @post.replies.find(params[:id])
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    render :show
  end

  def update
    @reply= @post.replies.find(params[:id])
    if authorize_author(@reply)
      if @reply.update(reply_params)
        redirect_to post_replies_path
      else
      render :edit
      end
    end
  end

  def destroy
    @reply = @post.replies.find(params[:id])
    authorize_author(@reply)
    @reply.destroy
    redirect_to post_replies_path
  end

  private
  def reply_params
    params.require(:reply).permit(:title, :content, :name)
  end

end
