# README

## Setup

### Ruby

Install the required Ruby version (2.7.1)

### Database

Install PostgreSQL

### Bundle

Like always, to make run the application, you need to run:

$ bundle install

To install the application gems.

### Javascript / webpack

Run: yarn install

### Database creation and migrate

Check and set up your "database.yml"
Run: rake db:create and rake db:migrate

### Start server

Run: rails s and check http://localhost:3000/

### RSpec

RAILS_ENV=test rake db:migrate
$ bundle exec rspec

All tests are in “/spec” folder.
