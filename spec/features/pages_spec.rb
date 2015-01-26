require 'rails_helper'

feature "Pages", :type => :feature, js: true do
  it "can be created by admin user" do
    user = create(:user)
    user.role = :admin
    login_as(user, scope: :user)

    visit new_page_path

    fill_in 'page_title', with: Faker::Lorem.sentence

    page.execute_script "$('iframe.wysihtml5-sandbox').contents().find('body').first().html('#{Faker::Lorem.sentence}')"
    page.execute_script "$('#page_category').val('blog')"
    page.execute_script "$('#page_state').val('published')"

    click_button 'Сохранить'

    expect(current_path).to eq(page_path(Page.last.id))
  end

  it "can't be created by common user" do
    login_as(create(:user), scope: :user)
    visit new_page_path
    expect(page).to have_text "Нет у вас доступа, я вижу."
  end
end
