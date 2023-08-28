class AccountsController < ApplicationController
  def show
    @account = current_user.account
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user

    if @account.save
      redirect_to root_path, notice: 'Account successfully created.'
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(:firstname, :lastname, :address, :dob, :phone, :gender, :balance)
  end
end
