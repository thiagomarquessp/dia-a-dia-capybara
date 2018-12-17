Before do
  Capybara.configure do |config|
    config.default_driver = :selenium
    config.app_host = CONFIG['url']
  end
  Capybara.default_max_wait_time = 10
end

After do
  unless BROWSER.eql?('chrome')
    Capybara.current_session.driver.quit
  end
end

After do |scenario|
  scenario_name = scenario.name
  file_name = scenario_name.gsub(' ', '_')
  img_path = "results/images/"
  shot = "#{img_path}/#{file_name.downcase!}.png"
  page.save_screenshot(shot)
  embed(shot, 'image/png', 'Clique aqui pra ver o PRINT :)')
end