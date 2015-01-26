class PagesController < ApplicationController

  load_and_authorize_resource

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  def index
    @pages = Page.latest_blog_posts.page(params[:page]).per(5)
  end

  # GET /pages/1
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to @page, notice: 'Страница успешно создана.'
    else
      render :new
    end
  end

  # PATCH/PUT /pages/1
  def update
    if @page.update(page_params)
      redirect_to @page, notice: 'Страница успешно обновлена.'
    else
      render :edit
    end
  end

  # DELETE /pages/1
  def destroy
    # @page.destroy
    @page.update_attribute(:state, Page.states[:deleted])
    redirect_to pages_url, notice: 'Страница успешно удалена.'
  end

  private
    def set_page
      if user_signed_in? && current_user.admin?
        @page = Page.where(id: params[:id]).first!
      else
        @page = Page.published.where(id: params[:id]).first!
      end
    end

    def page_params
      params.require(:page).permit(:title, :text, :category, :state)
    end
end
