require 'rails_helper'

RSpec.describe "pages/show", :type => :view, skip: true do
  before(:each) do
    @page = assign(:page, create(:page))
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/State/)
  end
end
