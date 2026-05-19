# Photo Gallery - Rails + Hotwire

This is a small Rails 7.2.3 application built for Clever's Rails + Hotwire photo gallery challenge. It uses server-rendered Rails views with Turbo Streams and a Stimulus controller for responsive, no-full-page-reload like interactions.

The Rails app lives in the `photo-gallery` subdirectory of the fork. The original challenge brief is preserved in `README_SETUP.md` for reference.

## Implemented Features

- Session-based authentication with `has_secure_password` and `bcrypt`
- Two seeded demo users
- Photo gallery seeded from `photos.csv` with 10 photos
- Like/unlike behavior implemented as a POST toggle with Turbo Streams
- Stimulus-powered optimistic feedback while Turbo replaces the final server-rendered button state
- Responsive CSS grid for mobile, tablet, and desktop layouts
- Minitest coverage for models, controllers, seed data, and browser-level system flows

## Quick Start

Prerequisites:

- Ruby 3.1.3, as specified by `.ruby-version`
- Bundler
- SQLite3

From the parent directory that contains `photo-gallery`:

```bash
cd photo-gallery
bundle install
bundle exec rails db:create db:migrate db:seed
bundle exec rails server
```

Then visit `http://localhost:3000`.

The root path renders the login page. Visiting `/photos` while signed out redirects to `/login`.

## Demo Credentials

```text
Username: demo
Password: password123
```

```text
Username: test
Password: password456
```

## How Likes Work

1. Each photo renders a like form inside a Turbo Frame with an id like `photo_<id>_like`.
2. The form submits `POST /photos/:photo_id/likes`.
3. `LikesController#create` toggles the current user's `Like` record for that photo.
4. The controller responds with a Turbo Stream replacement for the matching frame.
5. The browser updates only the button and count, without a full page reload.

The gallery index also precomputes the current user's liked photo ids and like counts for the displayed photos, so the view does not have to query those values one card at a time.

## Routes

| Method | Path | Controller | Action |
| --- | --- | --- | --- |
| GET | `/` | sessions | new |
| GET | `/login` | sessions | new |
| POST | `/login` | sessions | create |
| DELETE | `/logout` | sessions | destroy |
| GET | `/photos` | photos | index |
| POST | `/photos/:photo_id/likes` | likes | create |

Rails framework routes for health checks, PWA assets, Turbo Native helpers, Action Mailbox, and Active Storage are also present.

## Key Files

- [config/routes.rb](config/routes.rb) - documented app routes
- [config/importmap.rb](config/importmap.rb) - Turbo, Stimulus, and controller pins
- [app/javascript/application.js](app/javascript/application.js) - JavaScript entrypoint
- [app/javascript/controllers](app/javascript/controllers) - Stimulus app registration and like button controller
- [app/controllers/sessions_controller.rb](app/controllers/sessions_controller.rb) - login/logout
- [app/controllers/photos_controller.rb](app/controllers/photos_controller.rb) - gallery index and like-count preloading
- [app/controllers/likes_controller.rb](app/controllers/likes_controller.rb) - POST toggle and Turbo Stream response
- [app/models](app/models) - `User`, `Photo`, and `Like`
- [app/views/photos](app/views/photos) - gallery page and like button partial
- [app/assets/stylesheets/application.css](app/assets/stylesheets/application.css) - layout, responsive grid, and visual styling
- [db/seeds.rb](db/seeds.rb) - demo users and CSV photo import
- [photos.csv](photos.csv) - source photo data
- [test](test) - model, controller, seed, and system tests

## Testing

Run the model/controller/seed test suite:

```bash
bundle exec rails test
```

Run the browser system tests:

```bash
bundle exec rails test:system
```

Latest local verification:

```text
bundle exec rails test
39 runs, 72 assertions, 0 failures, 0 errors, 0 skips

bundle exec rails test:system
9 runs, 24 assertions, 0 failures, 0 errors, 0 skips
```

## Notes and Decisions

- Authentication intentionally uses Rails' built-in `has_secure_password` instead of Devise to keep the challenge scope focused.
- SQLite is the target database for local development and test.
- Likes are unique per `[user_id, photo_id]` through both a model validation and a database index.
- The app uses Importmap, Turbo, and Stimulus without a JavaScript bundler.
- Photo images use the CSV-provided Pexels `src.medium` URLs.

## Potential Improvements

- Add pagination, search, or filtering for larger photo collections
- Add user profiles or a sign-up flow
- Add comments or sharing actions
- Broadcast live like-count changes across users with Action Cable
- Add production image caching or proxying
