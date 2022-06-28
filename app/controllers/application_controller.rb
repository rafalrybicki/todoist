class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def authorize_user(user_id)
    redirect_to root_path unless current_user.id == user_id
  end

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html", layout: true, status: :not_found
  end
end
