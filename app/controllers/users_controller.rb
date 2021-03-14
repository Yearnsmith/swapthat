class UsersController < ApplicationController
  # How to set up User controller:
    # https://stackoverflow.com/questions/7086583/creating-a-users-show-page-using-devise
  # In case of Profile model:
    # https://stackoverflow.com/questions/4307743/profile-model-for-devise-users
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(username: params[:username])
  end
  def destroy
  end
end
