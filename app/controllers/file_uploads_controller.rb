class FileUploadsController < ApplicationController
  before_action :authenticate_user!, except: [:download]
  before_action :set_file_upload, only: [:show, :edit, :update, :destroy]

  # GET /file_uploads
  def index
    @file_uploads = FileUpload.latest.page(params[:page]).per(20)
  end

  # GET /file_uploads/1
  def show
  end

  # GET /file_uploads/new
  def new
    @file_upload = FileUpload.new
  end

  # GET /file_uploads/download
  def download
    file_upload = FileUpload.find_by! file_name: params[:file_name]

    send_file file_upload.file_path,
              filename: file_upload.original_file_name,
              type: file_upload.file_type
  end

  # POST /file_uploads
  def create
    uploader = FileUploader.new(
        file_name:            params[:name],
        file_type:            params[:type],
        upload_id:            params[:upload_id],
        chunk:                request.raw_post,
        content_range_header: request.headers["Content-Range"]
    )

    uploader.upload!

    if uploader.file_upload.present? && !uploader.file_upload.new_record?
      render text: uploader.file_upload.id, status: :created
    else
      render plain: '', status: :partial_content
    end
  rescue StandardError => _e
    render plain: '', status: :unprocessable_entity
  end

  # DELETE /file_uploads/1
  def destroy
    @file_upload.destroy
    redirect_to file_uploads_url, notice: t('.notice')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_upload
      @file_upload = FileUpload.find(params[:id])
    end
end
