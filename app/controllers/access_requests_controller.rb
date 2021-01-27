class AccessRequestsController < ApplicationController

  before_action :require_admin_user

  def index
    @access_requests = User.outstanding_access_requests.paginate(page: params[:page])
  end

  def show
  end

  def update
    user = User.find(params[:id])

    if user.update(update_params)
      if user.active?
        flash[:success] = "Access request approved."
        AccessRequestsMailer.approved_email(user).deliver_now
      else
        flash[:success] = "Access request rejected."
        AccessRequestsMailer.rejected_email(user).deliver_now
      end
    else
      flash[:error] = "Unknown option passed, please approve or reject the access request."
    end

    redirect_to access_requests_url
  end

  private

  def update_params
    params.require(:user).permit(:status)
  end
end
