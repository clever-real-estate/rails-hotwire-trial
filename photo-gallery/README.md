# Photo Gallery

A small Rails + Hotwire photo gallery app for the Clever coding challenge.

Users can sign in, browse seeded photos, and like or unlike photos without a full page reload.

## Requirements

- Ruby 4.0.3
- Bundler 4.0.6
- SQLite3

This app was built with Rails 8.1.3, Devise, Turbo, Stimulus, and Tailwind.

## Setup

Install dependencies and prepare the database:

```sh
bundle install
bin/rails db:prepare
bin/rails db:seed
```

## Login Credentials

```text
Email: demo@example.com
Password: password123
```

The demo user and photos are created from `db/seeds.rb`. Photo data is loaded from `db/photos.csv` into the database.

## Run The App

```sh
bin/dev
```

Then open:

```text
http://localhost:3000
```

## Run Tests

```sh
bundle exec rspec
```

The test suite covers authentication redirect behavior, duplicate-like validation, and the like/unlike user flow.

## Implementation Notes

- Authentication uses Devise with a seeded demo user because the challenge does not require sign-up.
- Photos are imported from `db/photos.csv` in `db/seeds.rb` and persisted in the database, so the CSV is not read at runtime.
- Likes are modeled with a join table between users and photos. A unique database index on `[user_id, photo_id]` ensures each user can like a photo only once.
- The like/unlike button is wrapped in a Turbo Frame so only that photo's like UI updates after each action.
- A small Stimulus controller provides immediate icon feedback while Turbo replaces the frame with the persisted server state.
- 3 Meaningful Rspec specs to exercise core functionality and requirements
