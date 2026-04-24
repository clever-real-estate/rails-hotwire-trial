require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [ 1200, 800 ], process_timeout: 10)
end

Capybara.javascript_driver = :cuprite
Capybara.enable_aria_label = true

RSpec.configure do |config|
  config.before(:each, type: :system)            { driven_by :rack_test }
  config.before(:each, type: :system, js: true)  { driven_by :cuprite }
end
