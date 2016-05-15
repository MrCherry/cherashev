require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before { sign_in create(:user, role: :admin) }

  let(:valid_attributes)   { attributes_for(:page) }
  let(:invalid_attributes) { attributes_for(:page, title: nil) }
  let(:page) { create(:page, state: Page.states[:published]) }

  describe "GET index" do
    it "assigns all pages as @pages" do
      get :index
      expect(assigns(:pages)).to eq([page])
    end
  end

  describe "GET blog" do
    it "assigns all pages as @pages" do
      blog_page = create(:page, category: Page.categories[:blog], state: Page.states[:published])
      get :blog
      expect(assigns(:pages)).to eq([blog_page])
    end
  end

  describe "GET show" do
    it "assigns the requested page as @page" do
      get :show, id: page.to_param
      expect(assigns(:page)).to eq(page)
    end
  end

  describe "GET new" do
    it "assigns a new page as @page" do
      get :new
      expect(assigns(:page)).to be_a_new(Page)
    end
  end

  describe "GET edit" do
    it "assigns the requested page as @page" do
      get :edit, id: page.to_param
      expect(assigns(:page)).to eq(page)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Page" do
        expect {
          post :create, page: valid_attributes
        }.to change(Page, :count).by(1)
      end

      it "assigns a newly created page as @page" do
        post :create, page: valid_attributes
        expect(assigns(:page)).to be_a(Page)
        expect(assigns(:page)).to be_persisted
      end

      it "redirects to the created page" do
        post :create, page: valid_attributes
        expect(response).to redirect_to(Page.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved page as @page" do
        post :create, page: invalid_attributes
        expect(assigns(:page)).to be_a_new(Page)
      end

      it "re-renders the 'new' template" do
        post :create, page: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { attributes_for(:page) }

      it "updates the requested page" do
        put :update, id: page.to_param, page: new_attributes
        page.reload
        expect(page.as_json.with_indifferent_access).to include(new_attributes)
      end

      it "assigns the requested page as @page" do
        put :update, id: page.to_param, page: valid_attributes
        expect(assigns(:page)).to eq(page)
      end

      it "redirects to the page" do
        put :update, id: page.to_param, page: valid_attributes
        expect(response).to redirect_to(page)
      end
    end

    describe "with invalid params" do
      it "assigns the page as @page" do
        put :update, id: page.to_param, page: invalid_attributes
        expect(assigns(:page)).to eq(page)
      end

      it "re-renders the 'edit' template" do
        put :update, id: page.to_param, page: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "safe_delete the requested page" do
      expect {
        delete :destroy, id: page.to_param
        page.reload
      }.to change(page, :deleted?).to(true)
    end

    it "redirects to the pages list" do
      delete :destroy, id: page.to_param
      expect(response).to redirect_to(pages_url)
    end
  end
end
