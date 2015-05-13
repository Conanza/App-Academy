class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params)

    if @user
      @user.reset_session_token!
      redirect_to cats_url
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  private

    def session_params
      params.require(:user).permit(:username, :password)
    end
end
