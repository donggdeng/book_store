require 'rails_helper'

describe AuthenticationTokenService do
    describe '.call' do
        it 'should turn an authentication token' do
            token = described_class.call
            decoded_token = JWT.decode(
                token, 
                described_class::HMAC_SECRET, 
                true, 
                { algorithm: described_class::ALGORITHM_TYPE }
            )
            
            expect(decoded_token).to eq(
                [
                    {"test" => "blah"},
                    {"alg" => described_class::ALGORITHM_TYPE}
                ]
            )
        end
    end
end