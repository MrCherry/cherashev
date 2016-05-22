module PagesHelper
  def categories_options
    Page.categories.map do |category, _|
      attribute_enum_option :page, category, :categories
    end
  end

  def states_options
    Page.states.map do |state, _|
      attribute_enum_option :page, state, :states
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
