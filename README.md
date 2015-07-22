# Drupal Batch People Creator
Need to create a bunch of new users for your Drupal website? This script takes usernames, passwords, and other information from a CSV and creates them in a fraction of the time it would take to do so manually and without the need to install any Drupal modules.

## Screenshot

![screenshot of Drupal Batch People Creator](https://cloud.githubusercontent.com/assets/7942714/8230098/f2f6d190-158a-11e5-8447-270fbb966401.png)

## Installation

```
git clone git://github.com/nholden/drupal-batch-people.git
cd drupal-batch-people
bundle install
```

## Getting started

1. Create a new config.yml file using config_example.yml as a template. Fill in your Drupal website's URL and your administrator account's username and password.
2. Create a new people.csv file using people_example.csv as a template. For each user you would like to create, fill in a username, email address, password, status (likely Active or Blocked), notify (0 will not email a notification to the new user, 1 will), and roles (separated by commas).
3. From the command line, run:
```
ruby create_people.rb
```

## Credits
This project was created by Nick Holden and is licensed under the terms of the MIT license.
