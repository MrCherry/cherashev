class Page < ActiveRecord::Base
  enum category: [:static, :blog]
  enum state: [:draft, :published, :archived, :deleted]

  validates :title, presence: true

  scope :published, ->{where(state: Page.states[:published])}

  scope :latest_blog_posts, ->{
    published.where(category: Page.categories[:blog]).order('created_at DESC')
  }
end
