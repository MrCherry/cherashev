require 'rails_helper'

RSpec.describe FileUpload, type: :model do
  subject { create(:file_upload) }

  describe 'validations' do
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

  describe 'instance method' do
    let(:file_name) { 'testname.txt' }

    before :each do
      allow(subject).to receive(:file_name).and_return file_name
    end

    describe 'file_path' do
      it 'returns full path for file' do
        expected_path = Rails.configuration.uploads_path.join(file_name).to_s
        expect(subject.file_path).to eq expected_path
      end
    end

    describe 'remove_file' do
      it 'calls FileUploader::remove_file' do
        expect(FileUploader).to receive(:remove_file).with subject.file_path
        subject.send(:remove_file)
      end
    end
  end
end
