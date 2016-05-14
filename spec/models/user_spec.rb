require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'validates presence of required attibutes' do
      is_expected.to validate_presence_of(:email)
      is_expected.to validate_presence_of(:password)
    end

    it 'validates email uniqueness' do
      create(:user)
      is_expected.to validate_uniqueness_of(:email).case_insensitive
    end

    it 'defines enum for role attribute' do
      is_expected.to define_enum_for(:role).with(%i(visitor admin))
    end
  end

  context 'default role' do
    it 'equals :visitor by default' do
      user = create(:user)
      expect(user.role).to eq 'visitor'
    end
  end
end
