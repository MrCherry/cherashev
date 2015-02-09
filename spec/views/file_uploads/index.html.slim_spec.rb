require 'rails_helper'

RSpec.describe "file_uploads/index", :type => :view, skip: true do
  before(:each) do
    assign(:file_uploads, [
      FileUpload.create!(
        :file_name => "File Name"
      ),
      FileUpload.create!(
        :file_name => "File Name"
      )
    ])
  end

  it "renders a list of file_uploads" do
    render
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
  end
end
