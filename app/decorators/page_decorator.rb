class PageDecorator < BaseDecorator
  def publication_status
    if published?
      "#{state} #{updated_at}"
    else
      state
    end
  end

  def state
    I18n.t(object.state, scope: [:activerecord, :attributes, :page, :states])
  end

  def updated_at
    I18n.l(object.updated_at, format: :short)
  end

  def category
    I18n.t(object.category, scope: [:activerecord, :attributes, :page, :categories])
  end
end
