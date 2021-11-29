require 'rails_helper'

describe AuthenticationTokenService do
    describe '.encode' do
        it 'should turn an authentication token' do
            token = described_class.encode(1)

            decoded_token = JWT.decode(
                token, 
                described_class::HMAC_SECRET, 
                true, 
                { algorithm: described_class::ALGORITHM_TYPE }
            )
            
            expect(decoded_token).to eq(
                [
                    {"user_id" => 1},
                    {"alg" => described_class::ALGORITHM_TYPE}
                ]
            )
        end
    end
end