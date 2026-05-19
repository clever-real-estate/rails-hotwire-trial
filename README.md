# Photo Gallery - Rails + Hotwire Challenge

This fork contains a completed Rails + Hotwire photo gallery application for Clever's coding challenge.

The Rails app lives in [`photo-gallery`](photo-gallery). The original challenge brief is preserved at [`photo-gallery/README_SETUP.md`](photo-gallery/README_SETUP.md).

## Run Locally

From this repository root:

```bash
cd photo-gallery
bundle install
bundle exec rails db:create db:migrate db:seed
bundle exec rails server
```

Then open `http://localhost:3000`.

Demo login:

```text
Username: demo
Password: password123
```

## Tests

```bash
cd photo-gallery
bundle exec rails test
bundle exec rails test:system
```

Latest local verification:

```text
bundle exec rails test
39 runs, 72 assertions, 0 failures, 0 errors, 0 skips

bundle exec rails test:system
9 runs, 24 assertions, 0 failures, 0 errors, 0 skips
```

See [`photo-gallery/README.md`](photo-gallery/README.md) for the full implementation notes, routes, architecture, and tradeoffs.
