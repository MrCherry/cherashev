require 'rails_helper'

RSpec.describe PageDecorator, :type => :decorator  do
  let(:page) {
    page = create(:page)
    some_date = Time.zone.now
    page.updated_at = some_date
    page.decorate
  }
  subject { PageDecorator.first }

  context 'published' do
    it 'shows published date' do
      page.state = Page.states[:published]
      expect(page.publication_status).to end_with page.updated_at
    end
  end

  context 'unpublished' do
    it 'does not show published date' do
      page.state = Page.states[:draft]
      expect(page.publication_status).not_to end_with page.updated_at
    end
  end
end
