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

  ## Redirect to modal, very smelly, but might work for popping up
  ## a modal displaying a Trade instance?
  # def test_route
  #   redirect_to "#{user_listings_path}#test"
  # end

  def user_listings
    # @shown_user is the user who's profile is in the url bar.
    @shown_user = User.find_by(username: params[:username])
    @listings = @shown_user.listings
  end

  private

  # def user_params
  #   params.require(:user).permit(:username)
  # end

end
