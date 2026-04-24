
# README

# Photo Gallery (Rails + Hotwire)

A Ruby on Rails application that allows authenticated users to browse photos and like/unlike them using Hotwire (Turbo Frames) for seamless updates without page reloads.

---

## ✨ Features

- Session-based authentication (no signup required)
- Photo gallery seeded from CSV
- Like / Unlike photos (one like per user per photo)
- Hotwire Turbo Frames for real-time updates
- Counter cache for like counts
- Responsive layout using Flexbox

---

## Tech Stack

- Ruby on Rails 8.0.5
- SQLite3
- Hotwire (Turbo + Stimulus)
- ERB templates
- Vanilla CSS (Flexbox)

---

## 🚀 Setup Instructions

### 1. Install dependencies

bundle install

### 2. Setup Database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

### 3. Start Server
bin/rails server


#Special Note

I'm not too familiar with Turbo and Hotwire (although I've used them before in small projects). I spend a bit of time wiring up and if I had more time, would have included a cleaner UI than the
one I provided with a free small html libray. I also would have used A.I. to scaffold an rspec test suite for testing. As for stimulus, I'm not sure if it would have been completely necessary and I do consider it to be overkill for this small project, but it still would have been nice to find ways to make use of it.
