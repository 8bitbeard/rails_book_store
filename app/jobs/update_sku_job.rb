require 'net/http'

class UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_name)
    # Do something later
    # uri = URI('https://deelay.me/10000/https://picsum.photos/200/300')
    # res = Net::HTTP.get(uri)

    uri = URI('https://deelay.me/10000/https://gorest.co.in/public/v1/users')
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = {name: book_name, email: 'test@test.com', gender: 'male', status: 'active'}.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
end
