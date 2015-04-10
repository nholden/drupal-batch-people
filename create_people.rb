require 'capybara'
require 'yaml'
require 'pry'
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

  def navigate_to_add_user
    login
    visit "#{CONFIG['drupal_url']}/admin/people/people"
    click_link('Add user')
    raise "Failed to navigate to 'Add user' page" if !has_content?("allows administrators to register new users")
  end

  def add_user(username, email, password, status, notify, roles)
    navigate_to_add_user
    fill_in('Username', :with => username)
    fill_in('E-mail address', :with => email)
    fill_in('Password', :with => password)
    fill_in('Confirm password', :with => password)
    choose(status)
    check('Notify user of new account') if notify == 1
    roles.split(', ').each { |role| check(role) }
    click_button('Create new account')
    raise "Failed to add user #{username}" if !has_content?("Created a new user account for #{username}")
  end

  def add_users_from_csv(csv)
    csv = File.open(csv, "r")
    raise "people.csv not properly formatted" if csv.each_line.first != "username,email,password,status,notify,roles\n"
    csv.each_line do |line|
      line = line.split(',')
      while line.length > 6 do
        line[-2] += ",#{line[-1]}"     
        line.delete_at(-1)
      end
      line[4] = line[4].to_i
      line[5] = line[5].gsub("\n",'').gsub(/"/,'')
      binding.pry
      add_user(line[0], line[1], line[2], line[3], line[4], line[5]) 
    end
    csv.close
  end
end

AddPeople.new.add_users_from_csv("people.csv")
