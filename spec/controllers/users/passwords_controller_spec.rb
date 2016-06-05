require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  include Devise::TestHelpers

  describe 'GET index' do
    it 'returns http success' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
