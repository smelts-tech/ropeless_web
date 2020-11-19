class DeviceUploadController < ApplicationController
  def new
    @device_upload = DeviceUpload.new
  end

  def create
    @device_upload = DeviceUpload.new create_params
    @device_upload.uploaded_file.attach(create_params[:uploaded_file])
    @device_upload.save!
    @device_upload.process!

    flash[:success] = "Device upload file saved!"

    redirect_to device_uploads_url
  rescue DeviceUpload::InvalidDocument => error
    Rails.logger.error error.message
    flash[:error] = "Something was wrong with that document. Please contact support via email and attach the file."
    redirect_to new_device_upload_url
  rescue ActiveRecord::RecordInvalid => error
    Rails.logger.error error.message
    flash[:error] = "We weren't able to save that document."
    redirect_to new_device_upload_url
  end

  def index
    @device_uploads = DeviceUpload.order(id: :desc).all # TODO: paginate me
  end

  private

  def create_params
    params.require(:device_upload).permit(:fisher_id, :uploaded_file)
  end
end
