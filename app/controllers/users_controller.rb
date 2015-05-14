class UsersController < ApplicationController
  # signup form
  def new
    @user = User.new
    render :new
  end

  # signup user
  def create
    @user = User.new(user_params)

    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    if @user == current_user
      render :show
    else
      flash[:notices] = ["Not for your eyes"]
      redirect_to user_url(current_user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
