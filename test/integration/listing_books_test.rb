require 'test_helper'

class ListingBooksTest < ActionDispatch::IntegrationTest

  setup do
    @genre = Genre.create!(name: 'Fiction')

    @genre.books.create!(title: 'Pragmatic Programmer', rating: 5)#raise an error if it does not exist. That is what ! is for
    @genre.books.create!(title: 'Ender Game', rating: 4)
  end

  test 'listing books' do

    get '/api/books' #what endpoing are we hitting

    assert_equal 200, response.status #make sure that the resposne.status is 200
    assert_equal Mime::JSON, response.content_type #make sure that the response we get is in the json format

    books = json(response.body)[:books]
    assert_equal Book.count, books.size

    book = Book.find(books.first[:id])
    assert_equal @genre.id, book.genre.id
  end

  test 'lists top rated books' do

    get '/api/books?rating=5'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body)[:books].size
  end
end
