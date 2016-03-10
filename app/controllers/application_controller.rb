class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  unless Rails.env.development?
    rescue_from Exception do |e|
      redirect_to root_path, flash: {error: 'Упс. Ошибочка вышла...'}
    end
  end

  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_path, flash: {error: I18n::t('unauthorized')}
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    redirect_to root_path, flash: {error: 'Зачем искать несуществующее?'}
  end

  def after_sign_in_path_for(resource)
    edit_user_registration_path
  end
end
