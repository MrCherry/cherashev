require 'rails_helper'

RSpec.describe "pages/index", :type => :view, skip: true do
  before(:each) do
    assign(:pages, [
      Page.create!(
        :title => "Title",
        :text => "Text",
        :category => "Category",
        :state => "State"
      ),
      Page.create!(
        :title => "Title",
        :text => "Text",
        :category => "Category",
        :state => "State"
      )
    ])
  end

  it "renders a list of pages" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
