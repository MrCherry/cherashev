require 'rails_helper'

RSpec.feature "File uploads", type: :feature, js: true, driver: :selenium do
  before :each do
    admin = create(:user)
    admin.role = :admin
    admin.save
    login_as admin
  end

  it 'can be created' do
    visit new_file_upload_path

    within('#file_upload_form') do
      attach_file('file_upload[file]', File.join(Rails.root.join, 'spec', 'fixtures', '640.png'))
      first('input[type=submit]').click
      sleep 1
    end

    page.save_screenshot '/Users/drwg/1.png'

    expect(current_path).to eq file_upload_path(FileUpload.last)
  end
end
