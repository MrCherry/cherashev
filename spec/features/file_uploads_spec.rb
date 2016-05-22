require 'rails_helper'

RSpec.feature "File uploads", type: :feature, js: true do
  let(:valid_file)   { File.join(Rails.root.join, 'spec', 'fixtures', '640.png') }
  let(:invalid_file) { File.join(Rails.root.join, 'spec', 'fixtures', 'invalid.txt') }
  let!(:file_upload)        { create(:file_upload) }
  let!(:second_file_upload) { create(:file_upload) }

  before(:each ) { DownloadHelper::clear_downloads }

  context 'Admin user' do
    before(:each) { login_as(create(:user, role: :admin)) }

    let(:upload_file_proc) do
      proc do |file|
        within('#file_upload_form') do
          attach_file('file_upload[file]', file)
          first('input[type=submit]').click
        end
      end
    end

    describe 'create action' do
      before(:each) { visit new_file_upload_path }

      it 'succeeds on valid input' do
        upload_file_proc.call(valid_file)
        wait_for_xhr
        expect(current_path).to eq file_upload_path(FileUpload.last)
      end

      it 'fails on invalid input' do
        accept_alert do
          upload_file_proc.call(invalid_file)
        end

        expect(current_path).to eq new_file_upload_path
      end
    end

    describe 'show action' do
      it 'is available for admin user' do
        visit file_upload_path(file_upload)
        expect(page).to have_text(file_upload.file_name)
      end
    end

    describe 'index action' do
      before(:each) { visit file_uploads_path }

      describe 'is available for admin user' do
        it 'shows first file_upload' do
          expect(page).to have_text(file_upload.original_file_name)
        end

        it 'shows second file_upload' do
          expect(page).to have_text(second_file_upload.original_file_name)
        end

        it 'shows only two records' do
          expect(page).to have_selector('table tbody tr', count: 2)
        end
      end
    end

    describe 'delete action' do
      let(:delete_button_xpath) { "//a[@data-method='delete' and contains(text(), '#{I18n.t('actions.delete')}')]" }

      before(:each) { visit file_upload_path(file_upload) }

      it 'is available on the show page' do
        expect(page).to have_selector(:xpath, delete_button_xpath)
      end

      it 'destroys file_upload entity' do
        accept_alert do
          page.find(:xpath, delete_button_xpath).click
        end

        expect(page).to have_text(I18n.t('file_uploads.destroy.notice'))
      end
    end

    describe 'download action' do
      it 'is available for downloading' do
        visit new_file_upload_path
        upload_file_proc.call(valid_file)
        wait_for_xhr
        page.find('.file-upload-download-link').click
        expect(DownloadHelper::download_content).to eq File.read(valid_file)
      end
    end
  end
end
