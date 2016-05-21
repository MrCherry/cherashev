require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'rescues from exceptions' do
    controller do
      def index
        raise StandardError.new('Just a test')
      end

      def show
        raise ActiveRecord::RecordNotFound
      end

      def edit
        raise CanCan::AccessDenied
      end
    end

    describe 'rescue_from StandardError' do
      before { get :index }

      it 'redirects to root_path' do
        expect(response).to redirect_to root_path
      end

      it 'sets proper flash error message' do
        expect(controller).to set_flash[:error].to I18n.t('errors.internal_server_error')
      end
    end

    describe 'rescue_from ActiveRecord::RecordNotFound' do
      before { get :show, id: 1 }

      it 'redirects to root_path' do
        expect(response).to redirect_to root_path
      end

      it 'sets proper flash error message' do
        expect(controller).to set_flash[:error].to I18n.t('errors.not_found')
      end
    end

    describe 'rescue_from CanCan::AccessDenied' do
      before { get :edit, id: 1 }

      it 'redirects to root_path' do
        expect(response).to redirect_to root_path
      end

      it 'sets proper flash error message' do
        expect(controller).to set_flash[:error].to I18n.t('errors.access_denied')
      end
    end
  end

  describe 'instance methods' do
    describe 'after_sign_in_path_for' do
      it 'returns path to editing user profile' do
        path = edit_user_registration_path
        expect(controller.after_sign_in_path_for(nil)).to eq path
      end
    end
  end
end
