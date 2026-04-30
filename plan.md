# Part 1 - Initial setup
1. Generate new rails app
    - `rails new . --database=sqlite3 --css=tailwind`  
2. Update gem file (devise, rspec) & move images

# Part 2 - Photo model + gallery setup
1.Photo model
- `rails g model Photo image_url:string source_url:string photographer_name:string photographer_url:string alt_text:text likes_count:integer`
- Seed photos `rails db:seed`
- generate photos controller 
- set root path
- confirm photos rendering on index

# Part 3 Tailwind + some views
- General tailwind card template for photo gallery

# Part 4 - User authentication with devise
- Devise (rails g devise:install, rails g devise:views, rails g devise User)
- seed users
- configure devise

# Part 5 - Like functionality (Includes hotwire)
- Add likes (rails g model Like user:references photo:references)
- Review counter cache (https://guides.rubyonrails.org/v7.2/association_basics.html#counter-cache)
- Review validations with scope (https://guides.rubyonrails.org/v7.2/active_record_validations.html#uniqueness)
- Set up likes/user/photo relationship
- Rspec

# Part 6 - Polish & Double check
- Polish UI (get clever colors)
- confirm mobile responsiveness
- update readme
- double check DB/seeds 