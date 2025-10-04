require 'rails_helper'

RSpec.describe SampleController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns JSON with correct message' do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Hello, this is a sample API response!')
    end
  end
end
