class PageDecorator < Draper::Decorator
  delegate_all

  def publication_status
    if published?
      "Опубликовано #{updated_at}"
    else
      "Не опубликовано  "
    end
  end

  def updated_at
    I18n::l(object.updated_at, format: :short)
  end
end