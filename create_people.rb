require 'capybara'
require 'yaml'
CONFIG = YAML.load_file("config.yml")

class AddPeople
  include Capybara::DSL

  def initialize
    Capybara.default_driver = :selenium
  end

  def login
    visit "#{CONFIG['drupal_url']}/user"
    fill_in('Username', :with => CONFIG['username'])
    fill_in('Password', :with => CONFIG['password'])
    click_button('Log in')
    false if !has_content?("People")
  end
end

AddPeople.new.login
