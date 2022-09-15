# frozen_string_literal: true

class StaticController < ApplicationController
  skip_before_action :authorized, only: :home

  def home; end
end
