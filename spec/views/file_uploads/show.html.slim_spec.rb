require 'rails_helper'

RSpec.describe "file_uploads/show", :type => :view, skip: true do
  before(:each) do
    @file_upload = assign(:file_upload, FileUpload.create!(
      :file_name => "File Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/File Name/)
  end
end
