class ApplicationController < ActionController::Base
  include Flashable

  helper_method :current_user
  helper_method :actions_allowed_on_article?

  rescue_from ActiveRecord::RecordNotFound do |err|
    redirect_to action: :index
    error_msg err
  end

  def handle_404
    render file: "#{Rails.root}/public/404.html", layout: false
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
      error_msg "You must be signed in to perform that action"
      redirect_to root_path
    end
  end

  def actions_allowed_on_article?
    current_user && (current_user == @article&.user || current_user.admin?)
  end
end
