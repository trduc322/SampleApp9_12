class SessionController < ApplicationController
  def new

  end
  def destroy
    forget(current_user)
    session.delete(:user_id)
    @current_user= nil
    flash[:success] = "log out"
    redirect_to login_path
  end

  
  def create
   @user = User.find_by email: params[:session][:email]
   if @user.present? && @user.authenticate(params[:session][:password])
    session[:user_id] = @user.id
    login_user @user
    if params[:session][:remember_me] == "1"
      remember @user
    else
     forget @user
    end

    flash[:success] = "login successful"
    redirect_to @user
   else
    flash.now[:danger] = "email or password incorrect!!"
    render :new
   end
  end
end
