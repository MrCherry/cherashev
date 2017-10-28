# Selenium
Capybara.register_driver :selenium_firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new

  # DownloadHelper
  profile['browser.download.dir'] = DownloadHelper::PATH.to_s
  profile['browser.download.folderList'] = 2
  profile['browser.helperApps.neverAsk.saveToDisk'] = 'image/png'

  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end

# Selenium chrome driver
Capybara.register_driver :selenium_chrome do |app|
  profile = Selenium::WebDriver::Chrome::Profile.new

  # DownloadHelper
  profile['download.default_directory'] = DownloadHelper::PATH.to_s

  Capybara::Selenium::Driver.new(app, browser: :chrome, profile: profile)
end

Capybara.javascript_driver = :selenium_chrome
