require "rails_helper"

RSpec.describe 'Root', :type => :routing do
  it "routes to #index" do
    expect(:get => "/").to route_to("welcome#index")
  end
end
