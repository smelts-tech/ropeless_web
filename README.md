# README

* Ruby 2.7.2
* PostgreSQL 11.x w/ PostGIS

### setup

* `git clone git@github.com:smelts-tech/ropeless_web.git`
* `bundle install`
* `rake db:create db:schema:load db:test:prepare`
* TODO: a task to import devices and device events from a file (Ryan help?)
