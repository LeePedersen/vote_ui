class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  after_action :updated_at

  def current_user
    if session[:user_id]
      return @current_user ||= User.find(session[:user_id])
    end
  end

  # def current_session
  #   if current_user
  #     SweepJob.perform_async(session)
  #   end
  # end

  def authorize
    if !current_user
      flash[:alert] = "Sign in to access that feature."
      redirect_to '/posts'
    end
  end

  def authorize_conversation(user, conversation)
    if current_user.id != conversation.user1_id && current_user.id != conversation.user2_id
      flash[:alert] = "You are not authorized to access that feature."
      redirect_to '/posts'
    end
  end

  def authorize_author(post)
    if !current_user || current_user.name != post.name
      flash[:alert] = "You are not authorized to access that feature."
      redirect_to '/posts' and return
    end
    true
  end

  def updated_at
    if session[:user_id]
      current_time = Time.new
      session[:updated_at] = current_time
    end
  end

  # def self.sweep(session)
  #   if session[:updated_at] < 20.minutes.ago
  #     session.destroy
  #     return true
  #   end
  #   false
  # end

end
