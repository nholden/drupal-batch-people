require 'yaml'
CONFIG = YAML.load_file("config.yml")

require 'capybara'
session = Capybara::Session.new(:selenium)
session.visit CONFIG['drupal_url']
