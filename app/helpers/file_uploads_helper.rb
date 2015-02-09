module FileUploadsHelper
  def download_link(file_upload)
    link_to file_upload.original_file_name, download_file_upload_path(file_upload.file_name), target: '_blank'
  end
end
