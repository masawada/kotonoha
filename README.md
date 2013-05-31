# README.md

## Requirements

## Installation
* `git clone https://github.com/masawada/kotonoha.git && cd kotonoha`
* (`git checkout -b develop origin/develop`)
* `bundle install --path vendor/bundle`
* `bundle exec rake db:migrate`
* `bundle exec rackup`

## Add users
* `bundle exec ruby scripts/user.rb gen username`
* `sqlite3 db/development.db`
* `select * from keys;`
* copy access key and secret key

## How to update leaves (statuses)
* add signature param (generate with access key and secret key) when you post statuses to kotonoha server.
* Read API Reference(docs/api.md) and Auth Reference(docs/auth.md)

## License
* MIT License

Produced by [@masawada](https://twitter.com/masawada)
