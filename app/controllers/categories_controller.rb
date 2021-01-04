# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :require_params, only: %i[show edit update]
  before_action :require_admin, except: %i[show index]
  def index
    @category = Category.paginate(page: params[:page], per_page: 3).order(created_at: :desc)
  end

  def show
    @article = @category.articles.paginate(page: params[:page], per_page: 3)
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

  def edit 

  end

  def update  
    if @category.update(category_params)
      flash[:notice] = "Category has been updated successfully"
      redirect_to category_path
    else
      render 'edit'
    end
  end


  private
  def require_params
    @category = Category.find(params[:id])
  end

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
