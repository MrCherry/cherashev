# Selenium
Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new

  # DownloadHelper
  profile['browser.download.dir'] = DownloadHelper::PATH.to_s
  profile['browser.download.folderList'] = 2
  profile['browser.helperApps.neverAsk.saveToDisk'] = 'image/png'

  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end
Capybara.javascript_driver = :selenium

# Selenium chrome driver
# Capybara.register_driver :selenium_chrome do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end
