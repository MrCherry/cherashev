require 'rails_helper'

RSpec.describe FileUploader do
  describe 'instance methods' do
    let(:file_name)            { double :file_name }
    let(:file_type)            { double :file_type }
    let(:upload_id)            { double :upload_id }
    let(:chunk)                { double :chunk }
    let(:content_range_header) { '' }

    before do
      allow(chunk).to receive(:size).and_return 0
    end

    subject do
      described_class.new(
        file_name:            file_name,
        file_type:            file_type,
        upload_id:            upload_id,
        chunk:                chunk,
        content_range_header: content_range_header
      )
    end

    describe 'upload!' do
      let(:tmp_file_path) { double :tmp_file_path }

      before :each do
        allow(subject).to receive(:apply_chunk).with chunk
        allow(subject).to receive(:last_chunk_received?).and_return true
        allow(subject).to receive(:tmp_file_path).and_return tmp_file_path
      end

      it 'removes tmp file on failure' do
        allow(subject).to receive(:create_file_upload_record!).and_return false
        expect(described_class).to receive(:remove_file).with tmp_file_path
        subject.upload!
      end
    end
  end

  describe 'class methods' do
    describe 'remove_file' do
      let(:file_path) { double :file_path }

      it 'calls FileUtils::rm' do
        expect(FileUtils).to receive(:rm).with(file_path)
        described_class.remove_file file_path
      end
    end
  end
end
