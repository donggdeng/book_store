require 'rails_helper'

describe "Books API", type: :request do
    it 'should return all books' do
        FactoryBot.create(:book, title: '1984', author: 'George Orwell')
        FactoryBot.create(:book, title: 'The Time Machine', author: 'Someone')

        get '/api/v1/books'
        
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(2)
    end
end