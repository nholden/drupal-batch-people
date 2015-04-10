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
    raise "Login failed" if !has_content?("People")
  end

  def navigate_to_people
    login
    visit "#{CONFIG['drupal_url']}/admin/people/people"
  end
end

AddPeople.new.navigate_to_people
