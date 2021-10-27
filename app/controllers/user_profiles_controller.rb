# frozen_string_literal: true

class UserProfilesController < ApplicationController
  def show
    @profile = current_user
    # @user = User.find_by(id: params[:id])
  end

  def edit; end

  def update
    current_user
    respond_to do |format|
      if current_user.update(user_profile_params)
        format.html { redirect_to @profile, notice: 'El perfil ha sido actualizado' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @profile = current_user
  end

  def user_profile_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
