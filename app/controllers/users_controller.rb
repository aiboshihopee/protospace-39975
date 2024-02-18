class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototype_params = @user.prototypes.includes(:user)
  end
end
