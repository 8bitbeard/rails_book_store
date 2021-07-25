require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /api/v1/books' do
    before do
      FactoryBot.create(:book, title: '1984', author: 'George Orwell')
      FactoryBot.create(:book, title: 'The Time Machine', author: 'H.G Wells')
    end

    it 'should return all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eql(2)
    end
  end

  describe 'POST /api/v1/books' do
    it 'should create a new book' do
      expect {
        post '/api/v1/books', params: {
          book: {title: 'The Martian'},
          author: {first_name: 'Andy', author_last_name: 'Weir', age: '48'},
        }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eql(1)
    end
  end

  describe 'DELETE /api/v1/books/:id' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: 'George Orwell') }

    it 'should delete a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
