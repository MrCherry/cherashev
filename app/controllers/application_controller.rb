class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exception do |e|
    redirect_to root_path, flash: {error: 'Упс. Ошибочка вышла...'}
  end

  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_path, flash: {error: I18n::t('unauthorized')}
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    redirect_to root_path, flash: {error: 'Зачем искать несуществующее?'}
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      upmin.root_path
    else
      edit_user_registration_path
    end
  end
end
