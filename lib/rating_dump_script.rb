require './google-play.rb'
require 'csv'

# procedural code :(
# also doesnt filter for uniques ... yet

app_bundle_name = "com.microsoft.office.officehub"
start_page = 0
end_page = 1


gp = GooglePlay.new
reviews_array ||= []

(start_page..end_page).each do |i|
  # reviews_array << gp.reviews(app_bundle_name, page: i).select { |r| r.rating == 1 }
  reviews_array << gp.reviews(app_bundle_name, page: i)
  puts "scraped reviews from page #{i}"
  sleep 10.0
end

## write to the csv file

CSV.open("bad_rating_data-#{Time.now}.csv", "a+") do |csv|
  csv << reviews_array.flatten.first.keys # adds the attributes name on the first line
  reviews_array.flatten.each do |hash|
    csv << hash.values
  end
end