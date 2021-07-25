require 'rails_helper'

describe 'Books API', type: :request do
  let(:first_author) { FactoryBot.create(:author, first_name: 'George', last_name: 'Orwell', age: 46)}
  let(:second_author) { FactoryBot.create(:author, first_name: 'H.G', last_name: 'Wells', age: 78)}

  describe 'GET /api/v1/books' do

    before do
      FactoryBot.create(:book, title: '1984', author: first_author)
      FactoryBot.create(:book, title: 'The Time Machine', author: second_author)
    end

    it 'should return all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eql(2)
      expect(response_body).to eq(
        [
          {
            'id'=> 1,
            'title'=> '1984',
            'author_name'=> 'George Orwell',
            'autthor_age'=> 46
          },
          {
            'id'=> 2,
            'title'=> 'The Time Machine',
            'author_name'=> 'H.G Wells',
            'autthor_age'=> 78
          }
        ]
      )
    end
  end

  describe 'POST /api/v1/books' do
    it 'should create a new book' do
      expect {
        post '/api/v1/books', params: {
          book: {title: 'The Martian'},
          author: {first_name: 'Andy', last_name: 'Weir', age: '48'},
        }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eql(1)
      expect(response_body).to eq(
        {
          'id'=> 1,
          'title'=> 'The Martian',
          'author_name'=> 'Andy Weir',
          'autthor_age'=> 48
        }
      )
    end
  end

  describe 'DELETE /api/v1/books/:id' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: first_author) }

    it 'should delete a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
