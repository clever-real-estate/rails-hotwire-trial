# Photo Gallery

A photo gallery app where authenticated users can browse and like photos, built with Rails 8, Hotwire, and Bootstrap 5.

## Requirements

- Ruby 3.3.5
- Rails 8.0
- SQLite3

## Setup

```bash
git clone
cd photo-gallery
git checkout photo-gallery-by-khris
bundle install
rails db:migrate
rails db:seed
```

## Running the App

```bash
bin/dev
```

Visit `http://localhost:3000` and sign in with:

| Email                 | Password    |
| --------------------- | ----------- |
| user@photogallery.com | password123 |
| test@photogallery.com | password123 |

## Running Tests

```bash
bundle exec rspec
```

## Features

- Devise authentication — app is fully gated behind sign in
- Like/unlike photos with live updates via Turbo Streams
- Optimistic UI via Stimulus controller
- Responsive layout with Bootstrap 5
