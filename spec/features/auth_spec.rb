require 'rails_helper'

feature "Auth", :type => :feature, :js => true do
  context 'sign_in form' do
    it "signs in if given credentials are valid" do
      password = Faker::Internet.password(8)

      user = create(:user, password: password, password_confirmation: password)

      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password

      click_button 'Sign in'

      expect(page).to have_text 'Signed in successfully.'
    end

    it "doesn't sign in if given credentials are invalid" do
      visit new_user_session_path

      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: Faker::Internet.password(8)

      click_button 'Sign in'

      expect(page).to have_text 'Invalid email or password.'
    end
  end
end
