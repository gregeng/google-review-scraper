require './google-play.rb'
require 'csv'

def prompt(*args)
  print(*args)
  gets.chomp
end

class RatingScrape

  def run
    start_text
    id, num, out = get_inputs
    write_reviews(id, num, out)
  end

  def start_text
    print("\n\n=======================================================\n=========== Google Play Store Review Scraper ==========\n=======================================================\n")
  end

  def get_inputs
    app_bundle_name = ""
    out_file_name = ""
    num_reviews = 0


    while app_bundle_name == ""
      app_bundle_name = prompt "Please enter the app id: "
    end

    while num_reviews == 0
      num_reviews = prompt "Number of reviews to harvest (multiples of 20):  "
      num_reviews = num_reviews.to_i
    end

    while out_file_name == ""
      out_file_name = prompt "Please enter a filename to save this data to (CSV):  "
    end
    return app_bundle_name, num_reviews, out_file_name
  end


  def write_reviews(app_bundle_name, num_reviews, out_file_name)
    puts "Connecting to Google Play..."
    gp = GooglePlay.new
    reviews_array ||= []
    i, reviews_found = 0,0
    out_file = CSV.open(out_file_name, "w+")
    puts "Starting review scrape..."
    while(reviews_found < num_reviews)
      begin
        reviews_array = gp.reviews(app_bundle_name, page: i)
        reviews_array.flatten.each do |hash|
          out_file << hash.values
        end
        reviews_found += reviews_array.count
        puts "Scraped #{reviews_found} reviews..."
        sleep 10.0
        i+=1
      rescue
        sleep 5.0
      end
    end
    puts "#{reviews_found} reviews written to #{out_file_name}"

    out_file.close
  end
end