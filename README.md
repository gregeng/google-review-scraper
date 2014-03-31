# GooglePlayer

Ruby gem for fetching app info and reviews from Google Play.

## Dependencies

- Nokogiri

## Installation

Add this line to your application's Gemfile:

    gem 'google-player'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google-player

## Usage

```ruby
gp = GooglePlay.new

# App
app = gp.app('your.app.id')
puts app.name
puts app.image_url
puts app.developer
puts app.developer_mail
puts app.developer_web
puts app.category
puts app.rating_count
puts app.rating_counts
puts app.rating_average
puts app.description
puts app.recent_change
puts app.last_update
puts app.file_size
puts app.downloads
puts app.version
puts app.os_requried


# Review
reviews = gp.reviews('your.app.id')
reviews = gp.reviews('your.app.id', page: 0)
reviews = gp.reviews('your.app.id') { |r| (Date.today - r.date) < 7 }
reviews = gp.reviews('your.app.id', sort_order: :rating) { |r| r.rating == 5 }

reviews.each do |review|
  puts review.id
  puts review.user
  puts review.user_id
  puts review.title
  puts review.text
  puts review.date
  puts review.rating
end
```