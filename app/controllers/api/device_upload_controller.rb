class Api::DeviceUploadController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def create
    #temporarily tag with the first fisher until we have auth
    params[:fisher_id] = Fisher.first.id

    @device_upload = DeviceUpload.new create_params
    @device_upload.data = params[:uploaded_file]
    @device_upload.save!
    @device_upload.process!

    response = { status: 'success'}
    self.status = 200
    self.response_body = response.to_json
  rescue DeviceUpload::InvalidDocument => error
    Rails.logger.error error.message
    response = { status: 'error', message: "Invalid Document. #{error.message}"}
    self.status = 400
    self.response_body = response.to_json
  rescue ActiveRecord::RecordInvalid => error
    Rails.logger.error error.message
    response = { status: 'error', message: "Error during processing.  #{error.message}"}
    self.status = 400
    self.response_body = response.to_json
  end

  private

  def create_params
    params.permit(:fisher_id, :uploaded_file)
  end
end
