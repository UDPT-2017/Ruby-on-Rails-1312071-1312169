class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session].nil?
      auth = request.env["omniauth.auth"]
      if auth["provider"] == "facebook"
        session[:omniauth] = auth.except "extra"
        user = User.login_from_omniauth auth
        user.save(validate: false)
        session[:user_id] = user.id
        flash[:success] = t ".login_success"
        redirect_to root_url
      end
    else
      user = User.find_by email: params[:session][:email].downcase
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        flash[:success] = t ".login_success"
        redirect_to root_url
      else
        flash.now[:danger] = t ".invalid"
        render :new
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
