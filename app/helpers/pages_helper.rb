module PagesHelper
  def categories_options
    Page.categories.map do |category, _|
      [
          t(category.to_sym, scope: [:activerecord, :attributes, :page, :categories]),
          category
      ]
    end
  end

  def states_options
    Page.states.map do |state, _|
      [
          t(state.to_sym, scope: [:activerecord, :attributes, :page, :states]),
          state
      ]
    end
  end

  def path_for_page(page)
    if page.blog?
      blog_post_path(page)
    else
      page_path(page)
    end
  end

  def back_path_for_page(page)
    if page.blog?
      blog_path
    else
      pages_path
    end
  end
end
