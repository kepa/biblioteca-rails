# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorized

  def authorized
    redirect_to root_path, flash: {notice: 'You must log-in!'} unless user_signed_in?
  end
end
