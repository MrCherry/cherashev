require 'rails_helper'

RSpec.describe "pages/new", :type => :view, skip: true do
  before(:each) do
    assign(:page, Page.new(
      :title => "MyString",
      :text => "MyString",
      :category => "MyString",
      :state => "MyString"
    ))
  end

  it "renders new page form" do
    render

    assert_select "form[action=?][method=?]", pages_path, "post" do

      assert_select "input#page_title[name=?]", "page[title]"

      assert_select "input#page_text[name=?]", "page[text]"

      assert_select "input#page_category[name=?]", "page[category]"

      assert_select "input#page_state[name=?]", "page[state]"
    end
  end
end
