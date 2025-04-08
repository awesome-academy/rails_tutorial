class PasswordResetsController < ApplicationController
  before_action :load_user,   only: %i(edit update)
  before_action :valid_user,  only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by(email: params.dig(:password_reset, :email)&.downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if user_params[:password].empty?
      @user.errors.add(:password, t(".error"))
      render :edit
    elsif @user.update(user_params)
      log_in @user
      @user.update_column(:reset_digest, nil)
      flash[:success] = "Reset Password success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by(email: params[:email])
    unless @user
      flash[:danger] = "User not found!"
      redirect_to root_url
    end
  end

  def valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      flash[:danger] = "Invalid reset link"
      redirect_to root_url
    end
  end
  
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end
