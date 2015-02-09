require 'rails_helper'

RSpec.describe "file_uploads/new", :type => :view, skip: true do
  before(:each) do
    assign(:file_upload, FileUpload.new(
      :file_name => "MyString"
    ))
  end

  it "renders new file_upload form" do
    render

    assert_select "form[action=?][method=?]", file_uploads_path, "post" do

      assert_select "input#file_upload_file_name[name=?]", "file_upload[file_name]"
    end
  end
end
