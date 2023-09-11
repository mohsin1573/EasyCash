class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      
      if @user.save
        redirect_to user_account_path
      else
        render :new
      end
    end
  
 
  
  end
  