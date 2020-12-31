# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_users, only: %i[show edit update destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @user = User.all.paginate(page: params[:page], per_page: 3)
  end

  def show
    @article = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def new
    redirect_to articles_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to alpha blog, #{@user.username}"
      redirect_to(@user)
      session[:user_id] = @user.id
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your personal information has been updated successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User has been deleted successfully"
    session[:user_id] = nil if @user == current_user
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_users
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can just edit or delete your profile."
      redirect_to @user
    end
  end

end
