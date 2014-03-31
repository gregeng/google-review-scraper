require 'json'
require 'httpclient'
require './google-play/app'
require './google-play/review'
require './google-play/parser'

class GooglePlay
  BASE_URL    = 'https://play.google.com'
  SORT_ORDERS = [:newest, :rating, :helpfulness]

  include Parser

  def initialize
    @client = HTTPClient.new
  end

  def app(id)
    res = @client.get("#{GooglePlay::BASE_URL}  ", {:id => id})
    raise GooglePlay::App::NotFoundError.new("'#{id}' is not found") if res.status_code == 404
    parse_app(res.content)
  end

  def reviews(id, opts = {})
    page       = opts[:page] || :all
    sort_order = opts[:sort_order] || :newest

    if page.is_a?(Integer)
      return fetch_reviews(id, page, sort_order)
    else
      all_reviews = []
      i = 0
      loop do
        reviews = fetch_reviews(id, i, sort_order)
        return all_reviews if (all_reviews.size > 0) and (all_reviews.last.id == reviews.last.id)
        if block_given?
          reviews.each do |r|
            return all_reviews unless yield(r)
            all_reviews << r
          end
        else
          all_reviews += reviews
        end
        i += 1
      end
      return all_reviews
    end
  end

  private
  def fetch_reviews(id, page, sort_order)
    sort_order_num = GooglePlay::SORT_ORDERS.find_index { |s| sort_order == s } || 0
    res = @client.post("#{GooglePlay::BASE_URL}/store/getreviews", {
      :id              => id,
      :pageNum         => page,
      :reviewSortOrder => sort_order_num,
      :reviewType      => 1
    })
    html = JSON.parse(res.content.split("\n")[2] + ']')[0][2]
    raise GooglePlay::App::NotFoundError.new("'#{id}' is not found") if html.size == 0
    parse_review(html)
  end
end
