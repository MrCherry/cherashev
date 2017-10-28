require 'rails_helper'

RSpec.feature 'Pages', type: :feature, js: true do
  it 'can be created by admin user' do
    login_as(create(:user, role: :admin))

    visit new_page_path

    fill_in 'page_title', with: Faker::Lorem.sentence
    fill_in 'page_slug', with: Faker::Lorem.word.downcase

    page.execute_script "$('iframe.wysihtml5-sandbox').contents().find('body').first().html('#{Faker::Lorem.sentence}')"
    page.execute_script "$('#page_category').val('blog')"
    page.execute_script "$('#page_state').val('published')"

    click_button I18n.t('actions.save')
	  
    expect(current_path).to eq(page_path(Page.last&.slug))
  end

  it "can't be created by common user" do
    login_as(create(:user))
    visit new_page_path
    expect(page).to have_text I18n.t('errors.access_denied')
  end
end
