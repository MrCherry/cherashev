require 'rails_helper'

RSpec.describe Page, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      is_expected.to validate_presence_of(:title)
      is_expected.to validate_presence_of(:alias)
    end

    it 'defines enum for category attribute' do
      is_expected.to define_enum_for(:category).with %i(static blog)
    end

    it 'defines enum for state attribute' do
      is_expected.to define_enum_for(:state).with %i(draft published archived deleted)
    end
  end

  describe 'instance methods' do
    describe 'safe_delete' do
      it 'changes state to deleted if it is not deleted yet' do
        page = create(:page, state: :published)
        expect { page.safe_delete }.to change { page.state }.to 'deleted'
      end

      it 'does not change state if it is deleted already' do
        page = create(:page, state: :deleted)
        expect { page.safe_delete }.to_not change { page.state }
      end
    end

    describe 'restore' do
      it 'changes state to draft if it is deleted' do
        page = create(:page, state: :deleted)
        expect { page.restore }.to change { page.state }.to 'draft'
      end

      it 'does not change state if it is not deleted yet' do
        page = create(:page, state: :published)
        expect { page.restore }.to_not change { page.state }
      end
    end
  end
end
