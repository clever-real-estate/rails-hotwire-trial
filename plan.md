#Part 1
1. Generate new rails app
    - `rails new . --database=sqlite3 --css=tailwind`  
2. Update gem file (devise, rspec) & move images

#Part 2 Photo model + gallery setup
2. Photo model
- `rails g model Photo image_url:string source_url:string photographer_name:string photographer_url:string alt_text:text likes_count:integer`
- Seed photos `rails db:seed`
- generate photos controller 
- set root path
- confirm photos rendering on index

#Part 3
- general tailwind card template for photo gallery

#Part 4
- Devise

#Part 5
- Add likes