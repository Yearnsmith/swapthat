module ApplicationHelper
  
  module UserHelper
    def set_user
      @user = current_user
    end
  end

end
