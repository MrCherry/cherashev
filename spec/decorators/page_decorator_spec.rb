require 'rails_helper'

RSpec.describe PageDecorator, type: :decorator  do
  let(:some_datetime)     { Time.zone.now }
  let(:page)              { create(:page, updated_at: some_datetime).decorate }
  let(:not_pubished_page) { create(:page, updated_at: some_datetime, state: Page.states[:draft]).decorate }

  it 'decorates state' do
    expect(page.state).to eq I18n.t(page.object.state, scope: [:activerecord, :attributes, :page, :states])
  end

  it 'decorates category' do
    expect(page.category).to eq I18n.t(page.object.category, scope: [:activerecord, :attributes, :page, :categories])
  end

  it 'decorates updated_at' do
    expect(page.updated_at).to eq I18n.l(page.object.updated_at, format: :short)
  end

  it 'published shows publication date' do
    expect(page.publication_status).to eq "#{page.state} #{page.updated_at}"
  end

  it 'unpublished does not show publication date' do
    expect(not_pubished_page.publication_status).not_to include not_pubished_page.updated_at
  end
end
