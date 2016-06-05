class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  unless Rails.env.development?
    rescue_from StandardError, with: :internal_server_error
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from CanCan::AccessDenied, with: :access_denied

  def after_sign_in_path_for(_resource)
    edit_user_registration_path
  end

  private

  def internal_server_error
    redirect_to root_path, flash: { error: t('errors.internal_server_error') }
  end

  def not_found
    redirect_to root_path, flash: { error: t('errors.not_found') }
  end

  def access_denied
    redirect_to root_path, flash: { error: t('errors.access_denied') }
  end
end
