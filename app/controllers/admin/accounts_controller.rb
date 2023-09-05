class Admin::AccountsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @users = User.all
      @accounts = Account.all
    end
  
    def show
      @account = Account.find(params[:id])
  
      # Now that @account is loaded, you can access its associated user
      @user = @account.user
      
      # Fetch all accounts associated with the user
      @accounts = Account.where(user_id: @user.id)
    end
    
  
    def edit
        @account = Account.find(params[:id])
        @user = @account.user
    end
  
    def update
      if @account.update(account_params)
        flash[:notice] = 'User account was successfully updated.'
        redirect_to admin_account_path(@account)
      else
        render :edit
      end
    end
  
    def destroy
        @account = Account.find(params[:id])
        @account.destroy
      flash[:notice] = 'User account was successfully deleted.'
      redirect_to admin_accounts_path
    end
  
    def new
      @account = Account.new
    end
  
    def create
      @account = Account.new(account_params)
      if @account.save
        flash[:notice] = 'User account was successfully created.'
        redirect_to admin_account_path(@account)
      else
        render :new
      end
    end
  
    private
  
    def account_params
      params.require(:account).permit(:firstname, :lastname, :address, :dob, :phone, :gender, :balance, :image)
    end
  end
  