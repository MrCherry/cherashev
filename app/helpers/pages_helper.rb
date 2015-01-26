module PagesHelper
  def categories_options
    Page.categories.map do |category, i|
      [
          t(category.to_sym, scope: [:activerecord, :attributes, :page, :categories]),
          category
      ]
    end
  end

  def states_options
    Page.states.map do |state, i|
      [
          t(state.to_sym, scope: [:activerecord, :attributes, :page, :states]),
          state
      ]
    end
  end
end
