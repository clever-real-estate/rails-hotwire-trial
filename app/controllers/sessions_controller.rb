class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    redirect_to photos_path if signed_in?
  end

  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])

    if user
      log_in(user)
      redirect_to(session.delete(:return_to) || photos_path, notice: "Signed in as #{user.email}.")
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to sign_in_path, notice: "Signed out."
  end
end
