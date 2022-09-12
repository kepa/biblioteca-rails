class ApplicationController < ActionController::Base

  before_action :authorized

  def authorized
    redirect_to root_path unless user_signed_in?
  end

end
