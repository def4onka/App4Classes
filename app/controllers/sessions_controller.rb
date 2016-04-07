class SessionsController < ApplicationController
  def new
  end

  def create
    @login = params[:login]
    @user = User.where("upper(login) = upper(?)", @login).first
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = "Неверное имя пользователя или пароль"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

end
