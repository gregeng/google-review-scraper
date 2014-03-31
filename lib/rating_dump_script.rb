require './google-play.rb'
require 'csv'

# procedural code :(
# also doesnt filter for uniques ... yet

# Get application id
if ARGV[0].nil?
	app_bundle_name = "com.microsoft.office.officehub"
else
	app_bundle_name = ARGV[0]
end

if ARGV[1].nil?
	num_reviews = 500
else
	num_reviews = ARGV[1].to_i
end


gp = GooglePlay.new
reviews_array ||= []
i, reviews_found = 0,0
out_file = CSV.open("review_data-#{Time.now}.csv", "a+")
# (start_page..end_page).each do |i|
while(reviews_found < num_reviews)
  # reviews_array << gp.reviews(app_bundle_name, page: i).select { |r| r.rating == 1 }
  reviews_array = gp.reviews(app_bundle_name, page: i)
  reviews_array.flatten.each do |hash|
    out_file << hash.values
  end
  reviews_found += reviews_array.count
  puts "scraped reviews from page #{i}"
  puts "Scraped #{reviews_found} reviews"
  sleep 10.0
  i+=1
end

## write to the csv file

# CSV.open("bad_rating_data-#{Time.now}.csv", "a+") do |csv|
#   csv << reviews_array.flatten.first.keys # adds the attributes name on the first line
#   reviews_array.flatten.each do |hash|
#     csv << hash.values
#   end
# end