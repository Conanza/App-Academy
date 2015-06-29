class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )

    if @user
      login(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])

    logout(@user)
    redirect_to session_new_url
  end

  def new
    @session = Session.new
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
