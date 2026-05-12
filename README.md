# Clever Photo Gallery — Submission

A photo gallery built with **Rails 7.1 + Hotwire** (Turbo + Stimulus). Signed-in users browse 10 seeded photos and like/unlike them with no full-page reloads.

> The original challenge brief is preserved in full below the `---` divider.

## Quick start

```bash
# Ruby 3.1.3 (.ruby-version is set); chruby/rbenv/asdf all work.
bundle install
bin/rails db:prepare    # creates dev + test sqlite DBs and runs migrations
bin/rails db:seed       # idempotent: seeds users + 10 photos from photos.csv
bin/rails server        # http://localhost:3000
```

Sign in at `http://localhost:3000/sign_in`:

| Email | Password |
| --- | --- |
| `demo@clever.example` | `password` |
| `second@clever.example` | `password` |

A second user is seeded so you can sign in as each in two browser windows and watch the **live like-count broadcast** in real time.

## Running the tests

```bash
bin/rails test          # 20 model + controller + integration tests
bin/rails test:system   # browser-driven Capybara/Selenium test
```

> The system test self-skips if your chromedriver doesn't match your installed Chrome. To enable it, install a matching driver (`brew upgrade chromedriver` on macOS).

## What was built

### Requirements

- **Authentication** — `has_secure_password` + `User.authenticate_by` (timing-safe). Session-based, `reset_session` on log in / out to mitigate fixation. An `Authentication` concern provides `current_user`, `signed_in?`, and a `require_login` `before_action` applied site-wide; `SessionsController` opts out via `allow_unauthenticated_access`.
- **Gallery** — `photos#index` renders a responsive grid of all 10 seeded photos. Each card shows the image, photographer, a "Source" link, and a like button with current count.
- **Likes via Hotwire** — `POST/DELETE /photos/:id/like` respond with a Turbo Stream that replaces only the like button. No polling, no full-page reload, no JSON API.
- **Likes persist & are unique per user** — `Like(user, photo)` model with a composite **unique DB index** on `(user_id, photo_id)`, not just a model validation, so the constraint holds under race conditions.
- **No JS frameworks** — Hotwire only.

### Senior-level moves layered on top

1. **Real-time cross-user broadcasts** — the gallery subscribes via `turbo_stream_from "photos"`. When any user (re)acts to a photo, an `after_commit` callback on `Like` broadcasts a replace of just the count span — not the whole button, because the filled/outline star state is per-viewer. Open two browser windows as two users to see it.
2. **Optimistic UI Stimulus controller** (`optimistic_like_controller.js`) — flips the star + count locally before the server confirms, and reverts on a failed `turbo:submit-end`. SVG paths are kept in the controller so the swap needs no extra request.
3. **Counter cache** on `photos.likes_count` — denormalized so the gallery doesn't run a COUNT per card on every render.
4. **N+1 prevention for the per-user "liked?" flag** — `PhotosController#index` issues one query and builds a `Set` of liked photo IDs, then each card partial does a constant-time set lookup. No `liked_by?` query per card.
5. **Idempotent likes** — controller uses `find_or_create_by!` so a double-click is a no-op rather than a 422; the unique index is the safety net at the DB layer.
6. **Responsive images** — each card uses `srcset` (`src_small` 350w, `src_medium` 940w, `src_large` 1880w) + `sizes` so phones don't download desktop-resolution JPEGs. `loading="lazy"` + `decoding="async"`. The CSV's `avg_color` is set as a card `background-color`, so the placeholder feels designed rather than blank.
7. **Accessibility** — `aria-pressed` on the like button, `aria-label` with the photographer name, alt text taken from the CSV, visible `:focus-visible` rings, semantic header/main/article markup. Source links open in a new tab with `rel="noopener noreferrer"`.
8. **CSP-safe inline SVGs** rendered as partials (`shared/_star_fill`, `_star_line`, `_link_icon`, `_logo`), so swapping star state is part of the Turbo Stream and `currentColor` recoloring "just works".
9. **Tests** — 20 Minitest checks across the user/like models, sessions controller, photos controller, and likes controller; plus a Capybara system test that drives the real browser through the click → optimistic UI → Turbo Stream confirmation flow.
10. **Mobile-responsive layout** — CSS grid with `repeat(auto-fill, minmax(280px, 1fr))` so the gallery reflows from 1 column on phones to 4+ on wide screens, no media-query gymnastics needed; a single 480px breakpoint tightens header padding for small phones.
11. **Brakeman + RuboCop Omakase** added to `:development` for static analysis (`bundle exec brakeman` / `bundle exec rubocop`).

### Architecture notes

- **Why Turbo Streams over a Frame?** The like button drives two side-effects per click (toggle state + count) and we want cross-user count updates. Streams compose cleanly across both — the controller replaces the whole button for the actor, while the model broadcasts only the count span to everyone else.
- **Why the count is in its own `<span>` with its own DOM ID** — broadcasting the whole button would flip the star state for users who didn't click, since "liked" is per-viewer. Splitting the count out keeps the broadcast safely viewer-agnostic.
- **CSV is loaded once at seed time**, not at request time, per the brief.

### What I'd do next with more time

- **Background jobs** — push the broadcast through `broadcast_replace_later_to` so request latency isn't tied to the cable adapter.
- **Production rate limiting** — Rails 7.1 doesn't ship `rate_limit` (that's 7.2+). For production I'd add `rack-attack` to throttle login attempts and like spam.
- **Photo show page** — Turbo Frame–driven modal/lightbox for the full-resolution image, navigable with keyboard.
- **Pagination** — gallery with `turbo_frame_tag :photos` + `pagy` would scale past 10 without changing the markup.
- **CI** — GitHub Actions running `bin/rails test`, `bundle exec brakeman -q`, and `bundle exec rubocop` on PR.
- **Active Storage variants** — if the photos lived in our blob store, `image_processing` + `representable: true` would produce the same `srcset` on-the-fly without depending on Pexels' query-string thumbs.

---

# Clever's Rails + Hotwire Coding Interview

Welcome to Clever's full-stack coding challenge. You'll build a small but complete web application using **Ruby on Rails** and **Hotwire** (Turbo + Stimulus). The goal is to assess how you think about Rails conventions, server-rendered interactivity, and clean UI without a heavy JavaScript framework.

---

## The Challenge

Build a photo gallery application where authenticated users can browse and "like" photos — all without writing a separate API or client-side SPA.

---

## Requirements

### 1. Authentication

- A sign-in page that gates access to the rest of the app
- Users who are not signed in should be redirected to sign in
- You may use any approach you prefer: `has_secure_password`, Devise, or a simple session-based system
- No sign-up flow is needed — seed one or more users directly in `db/seeds.rb`

### 2. Photo Gallery

- Display all 10 photos from the provided `photos.csv` on a single "All Photos" page
- Seed the photos into your database from the CSV — do not read the CSV at runtime
- Each photo card should show:
  - The photo image (use the `src.medium` URL)
  - The photographer's name
  - A link icon + the photo's source URL (use `links.svg`)
  - A like button with the current like count (use `star-fill.svg` and `star-line.svg`)

### 3. Like Functionality (Hotwire)

- Signed-in users can like and unlike any photo
- **Likes must update without a full page reload** — use Turbo Streams or Turbo Frames
- Like counts must persist in the database
- Each user can like a photo only once

### 4. No JavaScript Frameworks

The interactivity must be implemented with **Hotwire** (Turbo + optionally Stimulus). Do not use React, Vue, or any other JS framework.

---

## Bonus

- Mobile-responsive layout
- A Stimulus controller for any client-side behavior (e.g. optimistic UI, toggling state)
- Meaningful test coverage (RSpec or Minitest)

---

## Assets Provided

| File | Purpose |
|------|---------|
| `photos.csv` | Photo data — seed this into your database |
| `logo.svg` | Clever "Ci" logo for the nav/header |
| `links.svg` | Link icon for each photo card |
| `star-fill.svg` | Filled star — shown when a photo is liked |
| `star-line.svg` | Outline star — shown when a photo is not liked |

---

## Getting Started

There is no starter application. Create a new Rails app from scratch:

```bash
rails new photo-gallery --database=sqlite3
cd photo-gallery
```

Hotwire (Turbo + Stimulus) ships with Rails 7+ by default. If you're on Rails 6, add:

```ruby
# Gemfile
gem "hotwire-rails"
```

---

## What We're Looking For

| Area | What to demonstrate |
|------|-------------------|
| **Rails conventions** | Resourceful routing, skinny controllers, proper use of models |
| **Hotwire / Turbo** | Turbo Streams or Frames for the like feature — not polling, not custom fetch |
| **Database design** | Appropriate models, associations, and constraints |
| **HTML/CSS** | Clean, readable markup; reasonable styling without a heavy framework |
| **Code quality** | Clear naming, no unnecessary complexity, code you'd be comfortable reviewing |

---

## Time

Most candidates complete the core requirements in 2–4 hours. If you run out of time, leave notes in your README describing what you'd do next rather than rushing.

---

## Submission

1. Fork this repository
2. Build your application in the fork (the Rails app can live at the repo root or in a subdirectory)
3. Include setup instructions in your README so we can run it locally
4. Open a pull request back to this repository
5. Email your recruiter point of contact

Questions? Reach out to ryan@movewithclever.com

---

## Design Reference

The UI doesn't need to be pixel-perfect, but aim for something clean and usable. A photo card should convey the image, photographer credit, source link, and like action clearly. Use the Clever brand color `#0075EB` where appropriate.
