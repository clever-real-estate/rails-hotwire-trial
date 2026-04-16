# Photo Gallery (Rails + Hotwire)

Just another to-do app? Nay. A simple photo gallery application built with Ruby on Rails and Hotwire. Authenticated users can browse photos and like/unlike them with real time UI updates. No full page reloads here.

Perfect for launching off and expanding with new features you want.

---

## Setup & Installation

### What I use

- Ruby (3.3.2)
- Rails 8
- SQLite3
- Bundler 2.5.9
- Devise for Authentication
- Tailwind CSS

---

### 1. Up and Running

```
git clone

bundle install

bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

bin/dev
```

I've created a test user within the seed file;
```
Email: test@example.com
Password: password123
```

### 2. Tests
Running RSpec
`bundle exec rspec`


### 3. Future Work

- I will probably start playing around with CI and adding security checks
- Better seeds. ETL projects are both fun, and having non-existent/incomplete local data to test out features can be a pain. 
- More enhancements around user functionality, and possibly some Stimulus