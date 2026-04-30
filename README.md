# CleverSnap - A photo gallery application by Vivian C.

A photo gallery application built with Ruby on Rails and Hotwire where signed in users can like and unlike photos. 
This was built as part of Clever's interview process.

## Stack
- Ruby 3.1.2
- Rails 7.1.6
- Hotwire (Turbo Streams)
- SQLite3
- Devise for authentication
- Tailwind CSS
- RSpec for testing

## Setup
```
bundle install
bin/rails db:setup
bin/rails server
```
Then visit `http://localhost:3000/`

## Running Specs
```
bundle exec rspec
```

## Seeded Users & Login Credentials
```
Email: grace@test.com
Password: test1234

Email: rocky@test.com
Password: test1234

Email: artemis@test.com
Password: test1234
```

## What's Implemented
- Authentication with Devise
- Like/unlike photos with Turbo Streams
- Per user uniqueness
- Mobile responsive with Tailwind CSS + Clever's custom colors

## What I Would Do Differently
- I would make early technical decisions more quickly, especially around CSV import and authentication
- I would reserve more time to implement a Stimulus controller, maybe the optimistic UI
- I would add more request and system specs
- Overall this was a fun challenge and a great opportunity to work through a Rails/Hotwire project

Original challenge can be found [here](clever-challenge.md)
>Build a photo gallery application where authenticated users can browse and "like" photos — all without writing a separate API or client-side SPA.

