class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root

  def authorize_user(user_id)
    redirect_to root_path unless current_user.id == user_id
  end

  private

  def redirect_to_root
    redirect_to root_path
  end
end
