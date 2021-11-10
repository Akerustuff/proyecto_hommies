# frozen_string_literal: true

class UserProfilesController < ApplicationController
  def show
    @profile = current_user
    @my_pending_tasks = current_user.user_pending_tasks
    @house = House.find_by(id: current_user.house_id)
    @house_members = @house.house_members
  end

  def edit; end

  def update
    current_user
    respond_to do |format|
      if current_user.update(user_profile_params)
        format.html { redirect_to user_profile_path, notice: 'El perfil ha sido actualizado' }
        format.json { render :show, status: :ok, location: user_profile_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def take_out_user
    @house = House.find_by(id: current_user.house_id)
    @user = User.find(params[:id])
    @user.change_ownership_tasks
    @user.unassign_tasks
    @user.house_id = nil
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_profile_path, notice: 'Lo has sacado de la casa.' }
        # format.json { render :show, status: :created, location: @house }
      else
        format.html { redirect_to user_profile_path, status: :unprocessable_entity }
        # format.json { render json: @house.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @profile = current_user
  end

  def user_profile_params
    params.permit(:first_name, :last_name, :birthdate)
  end
end
