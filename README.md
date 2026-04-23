# README

Photo Gallery

* System dependencies

1) Devise (gem "devise")
2) CSV (gem 'csv')

* Running locally

1) Install Ruby (see .ruby-version) using RVM, rbenv, asdf or prefered version manager
2) Run bundle install
3) Run bin/setup

* Design and Functionality

1) 2 test users (the Smiths) are available. Emails and passwords are in seeds.rb. Each user can only like a photo once. There is a counter_cache on Photo that displays the total likes count (for all users) for each photo.
2) Photo Gallery uses a simple "Masonry Effect" design. When a user hovers over a photo, the Photographer, Like Button and Souce Link are displayed.
3) Mobile-responsive layout
4) The Clever brand color is used for link colors and the .liked class for the star-fill.svg icon.
5) Photo like/unlike funtionality is handled by Turbo Streams. There is also a Likable concern that handles macros and instance methods to help keep the Photo model lean.
6) Stimulus like controller implementing optimistic UI for like button

* Test Suite

Basic test coverage is provided...

Run all tests: bundle exec rspec

MODELS

photo_spec (bundle exec rspec spec/models/photo_spec.rb)
  - incrementing/decrementing the likes count
  - if a user has liked or not liked a photo

photo_like_spec (bundle exec rspec spec/models/photo_like_spec.rb)
  - does a PhotoLike belong_to a user and photo
  - is a PhotoLike unique per user and photo

REQUESTS

user_login_logout_spec (bundle exec rspec spec/requests/user_login_logout_spec.rb)
  - user redirects to login page after logout
  - unauthenticated user redirects to login page if trying to access authenticated route

photos_controller_spec (bundle exec rspec spec/requests/photos_controller_spec.rb)

  - returns a success response if user is logged and accesses photo gallery

likes_controller_spec (bundle exec rspec spec/requests/likes_controller_spec.rb)

  - creating a new PhotoLike increments photo likes by 1
  - destroying a new PhotoLike decrements photo likes by 1
