class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]

  def new; end

  def create
    user = User.find_by(username: session_params[:username])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Logged out successfully."
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end