require 'hashie'

class GooglePlay
  class App < Hashie::Mash
    class NotFoundError < StandardError; end
  end
end
