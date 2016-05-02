require 'rails_helper'

RSpec.describe PagesHelper, type: :helper do
  let(:static_page) { create(:page, category: Page.categories[:static]) }
  let(:blog_page)   { create(:page, category: Page.categories[:blog]) }

  describe 'options' do
    it 'categories_options' do
      options =
          Page.categories.map do |category, _|
            [
                t(category.to_sym, scope: [:activerecord, :attributes, :page, :categories]),
                category
            ]
          end

      expect(helper.categories_options).to eq options
    end

    it 'states_options' do
      options =
          Page.states.map do |state, _|
            [
                t(state.to_sym, scope: [:activerecord, :attributes, :page, :states]),
                state
            ]
          end

      expect(helper.states_options).to eq options
    end
  end

  describe 'path_for_page' do
    it 'returns blog_post_path for blog page' do
      expect(helper.path_for_page(blog_page)).to eq blog_post_path(blog_page)
    end

    it 'returns page_path for static page' do
      expect(helper.path_for_page(static_page)).to eq page_path(static_page)
    end
  end

  describe 'back_path_for_page' do
    it 'returns blog_path for blog page' do
      expect(helper.back_path_for_page(blog_page)).to eq blog_path
    end

    it 'returns pages_path for static page' do
      expect(helper.back_path_for_page(static_page)).to eq pages_path
    end
  end
end
