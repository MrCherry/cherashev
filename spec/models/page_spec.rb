require 'rails_helper'

RSpec.describe Page, type: :model do
  it 'validates presence of required fields' do
    is_expected.to validate_presence_of(:title)
    is_expected.to validate_presence_of(:alias)
  end
end
