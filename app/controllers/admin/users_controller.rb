class Admin::UsersController < AdminController

  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    user = User.find(params[:id])

    if user.update(update_params)
      UsersMailer.deactivated_email(user).deliver_now if user.deactivated?
      flash[:success] = "Changes saved"
    else
      flash[:error] = "Unable to save that change"
    end

    redirect_to admin_users_url
  end

  private

  def update_params
    params.require(:user).permit(:status)
  end
end
