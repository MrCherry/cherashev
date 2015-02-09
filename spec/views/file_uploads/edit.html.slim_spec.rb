require 'rails_helper'

RSpec.describe "file_uploads/edit", :type => :view, skip: true do
  before(:each) do
    @file_upload = assign(:file_upload, FileUpload.create!(
      :file_name => "MyString"
    ))
  end

  it "renders the edit file_upload form" do
    render

    assert_select "form[action=?][method=?]", file_upload_path(@file_upload), "post" do

      assert_select "input#file_upload_file_name[name=?]", "file_upload[file_name]"
    end
  end
end
