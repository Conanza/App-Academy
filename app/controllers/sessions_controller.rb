class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notices] = ["Already logged in"]
      redirect_to users_url
    else
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )

    if !@user.nil?
      login_user(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["invalid username/pw combo"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    flash[:notices] = ["logged out successfully"]
    redirect_to new_session_url
  end


  private

    def session_params
      params.require(:session).permit(:username, :password)
    end
end
