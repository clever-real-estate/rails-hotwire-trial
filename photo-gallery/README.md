# 📸 Photo Gallery

A session-authenticated photo gallery built with Ruby on Rails. Users log in to browse a CSV-seeded photo grid and like/unlike photos via Turbo Streams — no page reloads, no JavaScript framework.

---

## Ruby Version

**Ruby 3.2+** recommended. Check your version:

```bash
ruby -v
```

---

## System Dependencies

| Dependency | Purpose |
|------------|---------|
| Ruby 3.2+ | Runtime |
| Rails 7.1+ | Framework |
| SQLite3 | Default database (development) |
| Node.js + npm | Asset pipeline (importmap fallback) |
| Bundler | Gem management |

Install Rails if needed:

```bash
gem install rails
```

---

## Configuration

No `.env` file or external API keys required. The app uses Rails' built-in session store and `has_secure_password` (bcrypt).

**Required asset files** — copy these into `app/assets/images/` before seeding:

```
logo.svg
links.svg
star-fill.svg
star-line.svg
```

**Required data file** — place in the project root:

```
photos.csv
```

> Open `photos.csv` and verify the exact column headers. If they differ from `title`, `photographer`, `src.medium`, and `url`, update `db/seeds.rb` accordingly.

---

## Setup

### 1. Install gems

```bash
bundle install
bundle add bcrypt
bundle add turbo-rails
bundle add stimulus-rails
```

### 2. Install Turbo and Stimulus

```bash
rails turbo:install
rails stimulus:install
```

---

## Database Creation

Generate models and run migrations:

```bash
rails g model User email:string password_digest:string
rails g model Photo title:string photographer:string src_medium:string source_url:string likes_count:integer:default:0
rails g model Like user:references photo:references
rails g migration AddUniqueIndexToLikes
```

Open the generated `AddUniqueIndexToLikes` migration and add:

```ruby
add_index :likes, [:user_id, :photo_id], unique: true
```

Then run:

```bash
rails db:migrate
```

---

## Database Initialization (Seeding)

```bash
rails db:seed
```

This will:
- Destroy and recreate all `User` and `Photo` records
- Create one demo user: `demo@example.com` / `password`
- Import all photos from `photos.csv`

Seed output confirms record counts:

```
Seeded 1 user(s) and N photos.
```

---

## Running the App

```bash
rails s

 lsof -ti:3000 | xargs kill -9
```

Visit [http://localhost:3000](http://localhost:3000) and sign in with:

```
Email:    demo@example.com
Password: password
```
---

## Features

- **Authentication** — Session-based login with bcrypt (`has_secure_password`). All routes require login; unauthenticated users are redirected to `/login`.
- **Photo Grid** — Responsive CSS grid seeded from CSV, displaying photo image, photographer credit, and source link.
- **Like / Unlike** — Toggled via Turbo Streams; the like button updates in place without a page reload. One like per user per photo enforced at the model level (`validates :user_id, uniqueness: { scope: :photo_id }`) and at the database level (unique index).
- **Like Count** — Maintained via `after_create` / `after_destroy` callbacks on the `Like` model using `increment!` / `decrement!`.

---

## Architecture

```
app/
├── controllers/
│   ├── application_controller.rb   # require_login before_action, current_user helper
│   ├── sessions_controller.rb      # login / logout
│   ├── photos_controller.rb        # index only
│   └── likes_controller.rb         # create / destroy with turbo_stream response
├── models/
│   ├── user.rb                     # has_secure_password, has_many :likes
│   ├── photo.rb                    # has_many :likes, liked_by?(user)
│   └── like.rb                     # belongs_to user + photo, callbacks
└── views/
    ├── layouts/application.html.erb
    ├── sessions/new.html.erb
    ├── photos/index.html.erb
    └── likes/
        ├── _button.html.erb
        ├── create.turbo_stream.erb
        └── destroy.turbo_stream.erb
```

**Routes summary:**

| Verb | Path | Action |
|------|------|--------|
| GET | `/` | `photos#index` |
| GET | `/login` | `sessions#new` |
| POST | `/login` | `sessions#create` |
| DELETE | `/logout` | `sessions#destroy` |
| POST | `/photos/:photo_id/likes` | `likes#create` |
| DELETE | `/photos/:photo_id/likes/:id` | `likes#destroy` |

---

## Test Suite

Tests are written with **RSpec** and cover controllers, models, and full system flows.

```
spec/
├── controllers/
│   ├── likes_controller_spec.rb     # create/destroy, Turbo Stream responses, auth guard
│   ├── photo_controller_spec.rb     # index, login redirect for guests
│   └── sessions_controller_spec.rb  # login success/failure, logout, redirect logic
├── models/
│   ├── like_spec.rb                 # uniqueness validation, increment/decrement callbacks
│   ├── photo_spec.rb                # liked_by? method, associations
│   └── user_spec.rb                 # has_secure_password, email validations
└── system/
    ├── authentication_spec.rb       # end-to-end login/logout flow in the browser
    └── photo_gallery_spec.rb        # gallery renders, like button toggles, count updates
```

### Setup

```bash
bundle add rspec-rails --group "development, test"
rails generate rspec:install
```

If system specs use a browser driver, also add:

```bash
bundle add capybara selenium-webdriver --group "development, test"
```
 
### Running Tests

```bash
# Full suite
bundle exec rspec

# Single file
bundle exec rspec spec/models/like_spec.rb

# By type
bundle exec rspec spec/models
bundle exec rspec spec/controllers
bundle exec rspec spec/system
```

---

## Services

No background jobs, cache servers, mailers, or search engines. All data is synchronous and database-backed.

---

## Deployment

This app is configured for development out of the box. For production:

1. **Set `SECRET_KEY_BASE`** in your environment:
   ```bash
   rails secret
   ```

2. **Switch the database** — update `config/database.yml` for PostgreSQL or MySQL if deploying to a managed platform (Render, Fly.io, Heroku, etc.).

3. **Precompile assets:**
   ```bash
   RAILS_ENV=production rails assets:precompile
   ```

4. **Set `RAILS_ENV=production`** and run:
   ```bash
   rails db:migrate
   rails db:seed
   rails s -e production
   ```

> For Heroku or Render, add a `Procfile`:
> ```
> web: bundle exec puma -C config/puma.rb
> ```

---

## Troubleshooting

**Likes not updating without page reload** — ensure `turbo-rails` is installed and `rails turbo:install` was run. Check that `javascript_importmap_tags` is present in `application.html.erb`.

**Seed fails with column errors** — open `photos.csv` and verify header names match the keys used in `db/seeds.rb` (`row["src.medium"]`, `row["url"]`, etc.).

**Images not loading** — confirm `logo.svg`, `links.svg`, `star-fill.svg`, and `star-line.svg` are in `app/assets/images/`.

**Double-like error** — if you see a uniqueness validation error in the UI, the unique index migration may not have run. Run `rails db:migrate` and verify with `rails db:schema:dump`.