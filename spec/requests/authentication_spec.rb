require 'rails_helper'

describe 'Authentication', type: :request do
    describe 'POST /authenticate' do
        it 'should authenticate the client' do
            post '/api/v1/authenticate', params: { username: 'BookSeller99', password: 'Password'}

            expect(response).to have_http_status(:created)
            expect(response_body).to eq({
                'token' => '123'
            })
        end

        it 'should return error when username is missing' do
            post '/api/v1/authenticate', params: { password: 'Password'}            

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_body.has_key?('error')).to be_truthy
            expect(response_body['error']).to include('param is missing or the value is empty: username')
        end
        
        it 'should return error when password is missing' do
            post '/api/v1/authenticate', params: { username: 'BookSeller99'}

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response_body.has_key?('error')).to be_truthy
            expect(response_body['error']).to include('param is missing or the value is empty: password')
        end
    end
end