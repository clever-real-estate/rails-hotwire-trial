# Photo Gallery

Rails 8 + Hotwire submission for Clever's coding interview.

## Running Locally

```bash
bin/setup
bin/rails db:seed
bin/rails server
```

Visit http://localhost:3000 and sign in with any of the seeded demo users:

- `demo1@example.com`
- `demo2@example.com`
- `demo3@example.com`

Password for all: `clever123`

Three users are seeded so you can sign in from multiple browsers and watch the like count update as different users like the same photo.

## Running Tests

```bash
bundle exec rspec
```

System specs use [Cuprite](https://github.com/rubycdp/cuprite) (headless Chrome via CDP), so a local Chrome or Chromium install is required.
