# Ecommerce Data Faker

Simple ruby service that continously generates fake data for a MySQL database. The schema is a very simplistic "ecommerce" model.

(Actually, this could probably work with any RDBMS that Sequel supports, but it has only been tested on - and is hard-coded to - MySQL.)

## Setup

1. Set up your ruby environment according to `.ruby-version`
1. Run `bundle install`
1. Create a config file: `cp config.example.yml config.yml`
1. Edit `config.yml` with your database hostname, username, and password. `wait_time_seconds` is how long to wait between inserting new order records.

## Executing

Just run `./data_faker` in your shell. When the app starts up it will check for any new database migrations to run. This means that on the first run it will create the schema and populate some starting data.

There's no fancy logging or daemonizing; the script will print some info every time a new record is inserted. Use ctrl+c to quit.

If you want to delete all the fake data and start again, run `./data_faker reset`

