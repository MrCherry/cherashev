require 'rails_helper'
require "cancan/matchers"

RSpec.describe "pages/edit", :type => :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      :title => "MyString",
      :text => "MyString",
      :category => "MyString",
      :state => "MyString"
    ))
  end

  it "renders the edit page form" do
    render

    assert_select "form[action=?][method=?]", page_path(@page), "post" do

      assert_select "input#page_title[name=?]", "page[title]"

      assert_select "input#page_text[name=?]", "page[text]"

      assert_select "input#page_category[name=?]", "page[category]"

      assert_select "input#page_state[name=?]", "page[state]"
    end
  end
end
