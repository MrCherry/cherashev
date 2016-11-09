class FileUpload < ApplicationRecord
  validates :original_file_name, presence: true
  validates :file_name, presence: true, uniqueness: true

  validates :file_type,
            inclusion: {
              in: %w(image/jpeg image/png image/bmp application/zip)
            }

  before_destroy :remove_file

  scope :latest, -> { order('created_at DESC') }

  def file_path
    Rails.configuration.uploads_path.join(file_name).to_s
  end

  private

  def remove_file
    FileUploader.remove_file file_path
  rescue => exception
    Rails.logger.info "Failed to remove file #{file_path} because #{exception}"
  end
end
