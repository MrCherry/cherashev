module ApplicationHelper
  def attribute_enum_option(klass, value, scope)
    [
      t(value.to_sym, scope: [:activerecord, :attributes, klass, scope]),
      value
    ]
  end
end
