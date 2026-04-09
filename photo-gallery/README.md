# Local Setup

```bash
# 1) Clone and enter the repo
git clone <your-fork-url>
cd rails-hotwire-trial

# 2) Enter the Rails app (it lives in a subdirectory)
cd photo-gallery

# 3) Use the project Ruby version
# .ruby-version => ruby-3.3.4
rvm use 3.3.4
# (or: rbenv local 3.3.4)

# 4) Install dependencies
bundle install

# 5) Create + migrate + seed the database
bin/rails db:setup
# (equivalent to db:create db:schema:load db:seed)

# 6) Start the app
bin/rails server
```

Open [http://localhost:3000](http://localhost:3000)

## Seeded Login

The seed file creates:

- Email: `test@example.com`
- Password: `test@example.com`

## Notes

- Database is SQLite (`storage/development.sqlite3`), so no external DB setup is required.
- Photo seed data is loaded from `photos.csv` at the repository root.
- If you want a clean reset:
  ```bash
  bin/rails db:drop db:create db:migrate db:seed
  ```
