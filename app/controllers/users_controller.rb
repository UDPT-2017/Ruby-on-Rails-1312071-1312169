class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show]
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.select(:id, :name, :email).order(name: :asc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @user = User.new
    if session[:errors] && session[:errors] == 0
      session[:errors] = nil
    else
      session[:errors] = 1
    end
  end

  def edit
    session[:errors] = 1
    session[:signuperrors] = {}
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

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
