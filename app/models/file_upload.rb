class FileUpload < ActiveRecord::Base
  validates :original_file_name, presence: true
  validates :file_name, presence: true, uniqueness: true

  before_destroy ->{
    FileUploader::remove_file file_path
  }

  scope :latest, ->{order('created_at DESC')}

  def file_path
    Rails.configuration.uploads_path.join(file_name).to_s
  end
end
