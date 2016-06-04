require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /blog' do
    it 'returns 200' do
      get blog_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /pages' do
    it 'returns 302' do
      get pages_path
      expect(response).to have_http_status(302)
    end
  end
end
