require 'rails_helper'

RSpec.describe "welcome/index.html.slim", :type => :view, skip: true do
  it "displays WIP page" do
    render
    expect(rendered).to have_content 'Мой сайт находится в разработке.'
  end
end
