require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
    let(:user){ FactoryBot.create(:user, password: 'Password1')}
    let(:book_name) { 'Harry Potter' }

    describe 'GET index' do
        before do
            allow(AuthenticationTokenService).to receive(:decode).and_return(user.id)
        end

        it 'should have a max limit of 100' do
            expect(Book).to receive(:limit).with(100).and_call_original
            
            get :index, params: {limit: 999}
        end
    end

    describe 'POST create' do
        context 'authorization header present' do    
            before do
                allow(AuthenticationTokenService).to receive(:decode).and_return(user.id)
            end 
    
            it 'should call UpdateSkuJob with correct params' do
                expect(UpdateSkuJob).to receive(:perform_later).with(book_name)
    
                post :create, params: {
                    author: {first_name: 'JK', last_name: 'Rowling', age: 48},
                    book: {title: book_name}
                }
            end
        end

        context 'missing authorization header' do
            it 'should return 401' do
                post :create, params: {}

                expect(response).to have_http_status(:unauthorized)
            end
        end
    end

    describe 'DELETE destroy' do
        context 'missing authorzation header' do
            it 'should return a 401' do
                delete :destroy, params: { id: 1 }

                expect(response).to have_http_status(:unauthorized)
            end
        end
    end
    
end