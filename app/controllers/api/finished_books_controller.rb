module Api
  class FinishedBooksController < ApplicationController

    #DONT WRITE QUERYS IN CONTROLLERS. IT LEADS TO CONFUSION AND DUPLICATION
    def index
      books = Book.finished

      respond_to do |f|
        f.json {render json: books, status: 200}
        f.xml {render xml: books, status: 200}
      end
    end
  end
end