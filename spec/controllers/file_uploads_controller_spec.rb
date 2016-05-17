require 'rails_helper'

RSpec.describe FileUploadsController, type: :controller do
  context 'managing' do
    before { sign_in create(:user, role: :admin) }

    describe "GET index" do
      it "assigns all file_uploads as @file_uploads" do
        file_upload = create(:file_upload)
        get :index
        expect(assigns(:file_uploads)).to eq([file_upload])
      end
    end
  end

  context 'downloading' do
    describe "GET download" do
      let(:file_upload) { create(:file_upload) }

      it "sends file of the found @file_upload" do
        expect(controller).to(
          receive(:send_file)
            .with(
              file_upload.file_path,
              filename: file_upload.original_file_name,
              type: file_upload.file_type
            )
        )

        get :download, {file_name: file_upload.file_name}
      end
    end
  end
end
