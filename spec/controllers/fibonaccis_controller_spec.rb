require 'rails_helper'

RSpec.describe 'Fibonaccis', type: :request do
  describe 'GET /index' do
    before do
      get '/api/v1/fibonaccis'
    end

    it 'Returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'Returns json' do
      expect(response.content_type).to start_with('application/json')
    end

    it 'returns last 10' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
      expect(json[0]['created_at'] > json[1]['created_at']).to be true
      expect(json[1]['created_at'] > json[8]['created_at']).to be true
      expect(json[8]['created_at'] > json[9]['created_at']).to be true
    end
  end

  describe 'POST /create' do
    context 'When request is valid' do
      before do
        post '/api/v1/fibonaccis', params: { "n": 15 }, as: :json
      end

      it 'Returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'Returns json' do
        expect(response.content_type).to start_with('application/json')
      end

      it 'Returns correct fibonacci in result' do
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:result]).to eq(610)
      end
    end

    context 'When request is invalid (missing req. parameter)' do
      before do
        post '/api/v1/fibonaccis', params: { "ns": 15 }, as: :json
      end

      it 'Returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'Returns an error message' do
        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:error]).to start_with('Required parameter')
      end
    end
  end
end
