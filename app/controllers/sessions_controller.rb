class SessionsController < ApplicationController
  before_action only:[:create, :new] do
    if already_signed_in?
      flash[:notice] = "Already signed in yo"
      redirect_to cats_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params)

    if @user
      login_user!
      redirect_to cats_url
    else
      # undefined method `errors' for nil:NilClass
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    session[:session_token] = nil
    @user.reset_session_token!
    redirect_to cats_url
  end

  private

    def session_params
      params.require(:user).permit(:username, :password)
    end

    def already_signed_in?
      @user = User.find_by(session_token: session[:session_token])
      return false if @user.nil?
      return session[:session_token] == @user.session_token
    end
end
