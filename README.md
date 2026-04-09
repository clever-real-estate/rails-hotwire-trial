# Photo Gallery

## Running locally

1. Install **Ruby 3.3.5** (see `.ruby-version`; use rbenv, asdf, or another version manager).
2. Install gems: `bundle install`
3. Create and migrate the database: `rails db:prepare`
4. Seed the database: `rails db:seed`
5. Start the app: `bin/rails server` (or `bin/dev`, which runs the same command)

Then open [http://localhost:3000](http://localhost:3000).

A test user is created in the seed file
```
username: test_user
password: password
```

To run tests: `bundle exec rspec`
