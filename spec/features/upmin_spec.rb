require 'rails_helper'

feature "Upmin", :type => :feature do

  it "is available for users with the admin role" do
    login_as(create(:admin_user), scope: :user)

    expect{
      visit upmin.root_path
    }.not_to raise_error
  end

  it "isn't available for users without the admin role" do
    login_as(create(:user), scope: :user)

    expect{
      visit upmin.root_path
    }.to raise_error
  end
end
