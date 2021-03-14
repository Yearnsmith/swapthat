class HomeController < ApplicationController
  def index
  end

  def show
    # redirect_to home_index_path
    render action: :index
  end
end
