require 'rails_helper'

RSpec.describe FileUploadsHelper, type: :helper do
  describe 'download_link' do
    let(:file_upload) { create :file_upload }

    it 'return proper link' do
      expected_link =
        link_to file_upload.original_file_name,
                download_file_upload_path(file_upload.file_name),
                target: '_blank',
                class: 'file-upload-download-link'

      expect(helper.download_link(file_upload)).to eq expected_link
    end
  end
end
