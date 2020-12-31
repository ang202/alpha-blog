class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to articles_path
        flash[:notice] = "Welcome back #{user.username}"
    else
        flash.now[:alert] = "Password error or email not registered"
        render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "Logged out"
    redirect_to root_path
  end

end