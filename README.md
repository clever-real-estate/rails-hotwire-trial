# Photo Gallery

A Rails photo gallery app where authenticated users can browse and "like" photos. Built with **Rails 8.1**, **Hotwire (Turbo + Stimulus)**, and **SQLite3**.

## Setup

**Prerequisites:** Ruby 4.0+ and Bundler.

```bash
git clone <repo-url>
cd clever-real-estate-challenge
bundle install
rails db:setup
```

`db:setup` creates the database, runs migrations, and seeds it with a demo user and 10 photos from the provided CSV.

## Running the App

```bash
bin/rails server
```

Visit [http://localhost:3000](http://localhost:3000). You'll be redirected to the sign-in page.

**Demo credentials:**

| Email | Password |
|-------|----------|
| `user@example.com` | `password` |

## Running Tests

```bash
bundle exec rspec
```

## Running the Linter

```bash
bundle exec rubocop
```

## How It Works

### Authentication

Session-based authentication using `has_secure_password`. A `before_action` on `ApplicationController` redirects unauthenticated users to `/login`. No sign-up flow — users are seeded directly.

### Photo Gallery

All 10 photos are displayed on a single page in a responsive CSS grid. Each photo card shows:

- The photo image (medium resolution from Pexels)
- The photographer's name
- A link icon pointing to the photo's source URL
- A like button with the current like count

### Like / Unlike (Hotwire)

Likes use **Turbo Frames** — clicking the star button submits a form that returns a Turbo Stream response, replacing only the like button without a full page reload. Each user can like a photo only once (enforced at both the model validation and database index level).

## Project Structure

| Layer | Key Files |
|-------|-----------|
| **Models** | `User`, `Photo`, `Like` — with `has_secure_password`, `has_many :through`, and a unique composite index on likes |
| **Controllers** | `SessionsController` (login/logout), `PhotosController` (index), `LikesController` (create/destroy with Turbo Stream responses) |
| **Views** | `photos/index` with a `_photo_card` partial, `likes/_like_button` partial wrapped in a `turbo_frame_tag` |
| **Tests** | RSpec model and request specs organized by requirements (authentication, gallery display, like/unlike, Turbo Stream responses) |

## What I'd Do Next

- Pagination if the photo set grows, and a `counter_cache` column on photos to avoid N+1 count queries
- System tests with Capybara for full end-to-end coverage of the Turbo Frame interactions
- Rate limiting on login attempts and the like endpoint
- Normalize emails (downcase/strip) before saving
