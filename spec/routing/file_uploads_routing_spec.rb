require 'rails_helper'

RSpec.describe FileUploadsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/file_uploads').to route_to('file_uploads#index')
    end

    it 'routes to #new' do
      expect(get: '/file_uploads/new').to route_to('file_uploads#new')
    end

    it 'routes to #show' do
      expect(get: '/file_uploads/1').to route_to('file_uploads#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/file_uploads').to route_to('file_uploads#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/file_uploads/1').to
        route_to('file_uploads#destroy', id: '1')
    end

    it 'routes to #download' do
      hex = Digest::MD5.hexdigest(Time.zone.now.to_s)

      expect(get: "/download/#{hex}").to
        route_to('file_uploads#download', file_name: hex)
    end
  end
end
