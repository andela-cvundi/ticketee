class Admin::ApplicationController < ApplicationController
  skip_after_action :verify_authorized, :verify_policy_scoped

  before_action :authorize_admin!

  def index
  end


  private

  def authorize_admin!
    authenticate_user!

    unless current_user.admin?
      redirect_to "/"
      flash[:danger] = "You must be an admin to perform this operation"
    end
  end

end
