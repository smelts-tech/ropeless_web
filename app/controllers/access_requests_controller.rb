class AccessRequestsController < ApplicationController

  before_action :require_admin_user

  def index
    @access_requests = User.outstanding_access_requests.paginate(page: params[:page])
  end

  def show
  end

  def update
    user = User.find(params[:id])

    if user.update_attributes(update_params)
      flash[:success] = "Changes saved"
    else
      flash[:error] = "Failed to save changes"
    end

    redirect_to access_requests_url
  end

  private

  def update_params
    params.require(:user).permit(:status)
  end
end
