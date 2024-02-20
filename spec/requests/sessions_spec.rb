require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST #create" do
    puts "Session test"
    let(:user) { create(:user, email: 'user@example.com', password: 'secretpassword') }

    context 'credenciales validas' do
      it 'creates a new session' do
        post '/api/v1/login', params: { email: user.email, password: 'secretpassword' }
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response['user']['id']).to eq(user.id)
        expect(json_response['token']).to be_present
      end
    end
    context 'credenciales invalidas' do
      it 'creates a new session' do
        post '/api/v1/login', params: { email: user.email, password: 'invalid' }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq("Invalid email or password")
      end
    end
  end
end
