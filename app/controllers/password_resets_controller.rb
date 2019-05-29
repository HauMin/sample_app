class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, 
    only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "email_send_with_pass"
      redirect_to root_url
    else
      flash.now[:danger] = t "email_address_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("cant_be_empty"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t "pass_has_been_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "user_not_found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def valid_user
    return if @user&.activated? && @user.authenticated?(:reset, params[:id])
    redirect_to root_url
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "pass_reset_has_expired"
      redirect_to new_password_reset_url
    end
  end
end
