class WelcomeController < ApplicationController
  def home
    redirect_to articles_path if current_user
  end
end
