RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 4444
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end

  config.before(:each, type: :system, js: true) do
    driven_by :remote_chrome
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 4444
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
end

# Chrome
Capybara.register_driver :remote_chrome do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new
  chrome_options.add_argument("--disable-notifications")
  url = 'http://selenium_chrome:4444/wd/hub'
  Capybara::Selenium::Driver.new(app,
    :browser => :remote,
    # :browser_name => :chrome,
    :url => url,
    :options => chrome_options)
  # caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
  #   'goog:chromeOptions' => {
  #     'args' => [
  #       'no-sandbox',
  #       'headless',
  #       'disable-gpu',
  #       'window-size=1680,1050'
  #     ]
  #   }
  # )
  # Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
end