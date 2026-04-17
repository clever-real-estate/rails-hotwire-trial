# Be Careful, This Plate is Hot(wire) - A Clever App

Yeah so this is my crack at the Clever coding challenge. Photo gallery with Hotwire/Turbo for real-time filtering and liking - no full page reloads. I know it's a bit overkill but I wanted to flex the Turbo Stream setup properly.

## AI DISCLOSURE

There were 2 parts I DID use AI on (Claude to be specific).
- Reformatting this README
- Diagnosing an issue with my spec/system browser tests...

## Quick Start

```bash
# Standard Rails setup
bundle install
rails db:create db:migrate db:seed
rails server
```

Hit up `http://localhost:3000`, sign in, and start liking photos.

Or if you're into Docker (who isn't):

```bash
docker compose build
docker compose run web rails db:create db:migrate db:seed
docker compose up
```

## What's in Here

- **Photo Gallery** — Grid view of photos (responsive, used bootstrap for speed)
- **Filtering** — All Photos / Liked / Not Liked (via Turbo Stream, no reloads)
- **Like Toggle** — Click star to like/unlike, updates instantly
- **User Auth** — Devise handles the boring auth stuff

Pretty straightforward. Users filter photos and like what they want. The whole thing updates in real-time via Turbo Streams.

## Stack

- Rails 8.1 (obviously)
- Hotwire/Turbo (came along for the ride)
- Bootstrap 5 + Tailwind (...sigh)
- SQLite
- Devise (user auth)
- RSpec (tested everything)

## Tests

I went full BDD on this. 24 test scenarios covering:
- Photo filtering workflows
- Like/unlike interactions  
- Turbo Stream responses
- Session state management
- All the edge cases I could think of

```bash
# Run 'em all
bundle exec rspec

# Just the stuff users see
bundle exec rspec spec/system

# API/Turbo Stream tests
bundle exec rspec spec/integration

# Controller logic
bundle exec rspec spec/controllers
```
## How It Actually Works

### Photos Controller
- `#index` — Loads all photos, sets filter to `:all`
- `#filter_photos` — Handles filtering (all/liked/not_liked), returns turbo_stream

### Likes Controller (nested under Photos::)
- `#create` — Like a photo, respects current filter, returns updated gallery
- `#destroy` — Unlike a photo, same deal

### The Turbo Magic
Everything goes through `filter_photos.turbo_stream.erb` which replaces the entire `photo_gallery` div with filtered photos. Session stores which filter you're on, so when you like/unlike, it re-fetches with that filter applied. I would've liked to make this a bit cleaner but given time constraints and other things I wanted to showcase, this is the result. I still think it's DRY in nature.

## Routes

```ruby
GET  /photos                              # Index
GET  /photos/filter_photos?filter=:type   # Filter (turbo_stream)
POST /photos/:photo_id/like               # Like (turbo_stream)
DELETE /photos/:photo_id/like             # Unlike (turbo_stream)
```

## Notable Design Decisions

1. **Single Turbo Stream Template** — All filtering and like/unlike use `filter_photos.turbo_stream.erb`. Keeps things DRY.

2. **Session-Based Filter State** — When you like/unlike, the server knows which filter you're on and returns the appropriate photos. No weird state mismatches.

3. **Minimal JS** — Stimulus just handles the view controller stuff. Turbo does the heavy lifting.

4. **Factory Bot for Tests** — Way cleaner than fixtures. Easy to create test data with relationships.

## Gotchas / Things I Ran Into

- **Turbo Stream Partial Paths** — When rendering from a nested controller (Photos::LikesController), Rails was looking for partials in the wrong directory. Solved by explicitly specifying the path in the loop.
- **Filter Buttons** — Had to make them links instead of buttons to work properly with Turbo. `link_to` with turbo_stream format param.
- **Like Count Updates** — Need to update the full gallery, not just the like button, because likes affect filtering. That's why we use the full turbo_stream template.
- **Tests** - I'm bullish on BDD so I think I spent as much time writing tests as I did writing the app. That said, I should note that I was able to pluck some existing test code here and there from current projects to speed that along.

## Stuff I Could Add But Didn't

- Photo upload (would need Active Storage)
- Pagination (not needed for challenge)
- Admin panel to manage photos
  - Would've also been cool to link logged in users with photos they owned
- Real-time like count from other users
- Search/tagging
  - This would've been a cool thing to add for the challenge
- Comments/Ratings

But yeah, for the challenge requirements, this is solid.

## Stats About This Challenge

- My total time for the challenge was 4 hours 26 minutes and some change
  - Without the diagnoses of the spec/system tests it was 3 hours and 41 minutes
- I DID use past code, especially for test setup to speed up the process (and prevent re-inventing the wheel). Also the `docker-compose.yml` file is largely a recycle of my past projects in rails
- I DID use AI as denoted above in the disclosure (limited capacity, did not use it on functionality)
- I DID debate on hiding an easter egg somewhere for the reviewers to find but ran out of time...it would've been a tiny t-rex in ascii, though
