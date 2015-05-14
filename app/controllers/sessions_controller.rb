class SessionsController < ApplicationController
  # signup form
  def new
    if logged_in?
      flash[:notices] = ["ALREADY LOGGED IN YO"]
      redirect_to user_url(current_user)
    else
      render :new
    end
  end

  # login user
  def create
    @user = User.find_by_credentials(
      session_params[:email],
      session_params[:password]
    )

    if !@user.nil?
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["EMAIL/PASSWORD COMBO INCORRECT"]
      render :new
    end
  end

  # logout user
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to new_session_url
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
