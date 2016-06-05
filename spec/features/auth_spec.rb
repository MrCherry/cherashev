require 'rails_helper'

RSpec.feature 'Auth', type: :feature do
  context 'sign_in form' do
    it 'signs in if given credentials are valid' do
      password = Faker::Internet.password(8)

      user = create(:user, password: password, password_confirmation: password)

      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: password

      click_button 'Войти'

      expect(page).to have_text 'Вход в систему выполнен.'
    end

    it 'does not sign in if given credentials are invalid' do
      visit new_user_session_path

      fill_in 'user_email', with: Faker::Internet.safe_email
      fill_in 'user_password', with: Faker::Internet.password(8)

      click_button 'Войти'

      expect(page).to have_text 'Неверный Email или пароль.'
    end
  end
end
