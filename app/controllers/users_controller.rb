class UsersController < ApplicationController
  def new
    @user = User.new
    if session[:errors] && session[:errors] == 0
      session[:errors] = nil
    else
      session[:errors] = 1
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".account_actived"
      session[:signuperrors] = {}
      redirect_to root_url
    else
      session[:signuperrors] = @user.errors.full_messages
      session[:errors] = 0
      redirect_to signup_url
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
