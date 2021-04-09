# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def index
    render :index, locals: { current_user: current_user }
  end
end
