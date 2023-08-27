class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      
      if @user.save
        redirect_to determine_account_path(@user)
      else
        render :new
      end
    end
  
    private
  
    def determine_account_path(user)
      if user.user?
        user_account_path
      elsif user.admin?
        admin_account_path
      elsif user.superadmin?
        superadmin_account_path
      else
        root_path
      end
    end
  
  end
  