class Page < ActiveRecord::Base
  enum category: %i(static blog)
  enum state: %i(draft published archived deleted)

  validates :title, presence: true
  validates :alias, presence: true # TODO: friendly_id

  scope :latest, ->{order('created_at DESC')}
  scope :published, ->{where(state: Page.states[:published])}
  scope :blog_posts, ->{where(category: Page.categories[:blog])}
  scope :latest_blog_posts, ->{latest.published.blog_posts}

  def safe_delete
    update_attributes(state: Page.states[:deleted]) unless deleted?
  end

  def restore
    update_attributes(state: Page.states[:draft]) if deleted?
  end
end
