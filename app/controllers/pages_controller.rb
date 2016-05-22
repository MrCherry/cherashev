class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:blog, :show]
  before_action :check_access
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  def index
    @pages = Page.latest.page(params[:page]).per(20).decorate
  end

  # GET /blog
  def blog
    @pages = Page.latest_blog_posts.page(params[:page]).per(5).decorate
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
      redirect_to page_path(@page), notice: t('pages.notices.created')
    else
      render :new
    end
  end

  # PATCH/PUT /pages/1
  def update
    if @page.update(page_params)
      redirect_to page_path(@page), notice: t('pages.notices.updated')
    else
      render :edit
    end
  end

  # DELETE /pages/1
  def destroy
    @page.safe_delete
    redirect_to pages_path, notice: t('pages.notices.deleted')
  end

  private

  def set_page
    relation = Page.where("id = CAST(? AS numeric) OR alias = ?", params[:id].to_i, params[:id].to_s)
    relation = relation.blog_posts if route_name == :blog_post
    relation = relation.published unless can?(:manage, Page)
    @page = relation.first!.decorate
  end

  def page_params
    params.require(:page).permit(:title, :text, :category, :state, :alias)
  end

  def route_name
    Rails.application.routes.router.recognize(request) do |route, _|
      return route.name.to_sym if route.name
    end
  end

  def check_access
    if !action_name.in?(%w(blog show)) && cannot?(:manage, Page)
      raise CanCan::AccessDenied
    end
  end
end
