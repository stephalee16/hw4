class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "username" => params["username"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome!"
        redirect_to "/places"
      else
        flash["notice"] = "Try Again."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Try Again."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Thank You."
    redirect_to "/login"
  end
end