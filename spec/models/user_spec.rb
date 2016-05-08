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
  end

  context 'roles' do
    it 'returns two roles by default' do
      expect(User.roles).to eq({'visitor' => 0, 'admin' => 1})
    end
  end

  context 'role' do
    it 'equals :visitor by default' do
      user = create(:user)
      expect(user.role).to eq('visitor')
    end

    it 'remembers given :admin role' do
      user = create(:user)
      user.role = :admin
      user.save
      expect(user.role).to eq('admin')
    end
  end

  context 'admin? method' do
    it 'exists' do
      user = create(:user)
      expect{user.admin?}.not_to raise_error
    end

    it 'returns true if user has got the admin role' do
      user = create(:user)
      user.role = :admin
      expect(user.admin?).to be_truthy
    end

    it 'returns false if user has not got the admin role' do
      user = create(:user)
      user.role = :visitor
      expect(user.admin?).to be_falsey
    end
  end

  context 'visitor? method' do
    it 'exists' do
      user = create(:user)
      expect{user.visitor?}.not_to raise_error
    end

    it 'returns true if user has got the visitor role' do
      user = create(:user)
      user.role = :visitor
      expect(user.visitor?).to be_truthy
    end

    it 'returns false if user has not got the visitor role' do
      user = create(:user)
      user.role = :admin
      expect(user.visitor?).to be_falsey
    end
  end
end
