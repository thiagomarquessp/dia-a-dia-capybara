require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'pry'
require 'rspec'

BROWSER = ENV['BROWSER']
ENVIRONMENT_TYPE = ENV['ENVIRONMENT_TYPE']

## variable which loads the data file according to the environment
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENVIRONMENT_TYPE}.yaml")

## Register driver according with browser chosen
Capybara.register_driver :selenium do |app|
  if BROWSER.eql?('chrome')
    options = ::Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--window-size=1920,1080')
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  elsif BROWSER.eql?('chrome_headless')
    options = ::Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1920,1080')
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
end