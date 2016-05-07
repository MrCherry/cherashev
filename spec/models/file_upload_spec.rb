require 'rails_helper'

RSpec.describe FileUpload, type: :model do
  it 'validates presence of required fields' do
    is_expected.to validate_presence_of(:original_file_name)
    is_expected.to validate_presence_of(:file_name)
  end

  it 'validates uniqueness of file_name field' do
    create(:file_upload)
    is_expected.to validate_uniqueness_of(:file_name)
  end

  it 'validates inclusion of file_type field' do
    is_expected.to validate_inclusion_of(:file_type).in_array(%w(image/jpeg image/png image/bmp application/zip))
  end
end
