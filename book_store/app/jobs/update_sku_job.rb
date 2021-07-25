class UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_name)
    # Do something later
    uri = URI('https://deelay.me/10000/https://picsum.photos/200/300')
    res = Net::HTTP.get(uri)
  end
end
