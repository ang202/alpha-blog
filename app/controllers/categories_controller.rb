# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[show index]
  def index
    @category = Category.paginate(page: params[:page], per_page: 3).order(created_at: :desc)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category was successfuly created'
      redirect_to @category
    else
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = 'Only admin can perform those action'
      redirect_to categories_path
    end
  end
end
