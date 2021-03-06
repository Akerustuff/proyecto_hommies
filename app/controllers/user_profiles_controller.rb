# frozen_string_literal: true

class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: %i[show edit update edit_ajax show_per_assign
                                            show_per_approve show_approved]
  skip_before_action :verify_authenticity_token, only: %i[edit_ajax]

  def show
    # @my_tasks = @profile.my_tasks
    @my_pending_tasks = @profile.user_pending_tasks
    @house = House.find_by(id: @profile.house_id)
    @house_members = @house.house_members
    @tasks_grouped_by_state = @profile.my_tasks.group(:aasm_state).count
  end

  def show_per_assign
    @per_assign_tasks = @profile.user_per_assign_tasks
    @house = House.find_by(id: @profile.house_id)
    @house_members = @house.house_members
    @tasks_grouped_by_state = @profile.my_tasks.group(:aasm_state).count
  end

  def show_per_approve
    @per_approve_tasks = @profile.user_per_approve_tasks
    @house = House.find_by(id: @profile.house_id)
    @house_members = @house.house_members
    @tasks_grouped_by_state = @profile.my_tasks.group(:aasm_state).count
  end

  def show_approved
    @approved_tasks = @profile.user_approved_tasks
    @house = House.find_by(id: @profile.house_id)
    @house_members = @house.house_members
    @tasks_grouped_by_state = @profile.my_tasks.group(:aasm_state).count
  end

  def edit; end

  def update
    respond_to do |format|
      if @profile.update(user_profile_params)
        format.html { redirect_to user_profile_path, notice: 'Tu perfil se ha actualizado con éxito' }
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
        # format.json { render(json: @house.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  def edit_ajax
    birthdate_string = "#{params[:year_birthdate]}-#{params[:month_birthdate]}-#{params[:day_birthdate]}"
    birthdate = birthdate_string.to_datetime
    if @profile.update({ first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate })
      response = {
        first_name: @profile.first_name,
        last_name: @profile.last_name,
        birthdate: @profile.birthdate
      }
      render json: response, status: :ok
    else
      render json: { message: 'Ha ocurrido un error, intente de nuevo' }, status: :error
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @profile = current_user
  end

  def user_profile_params
    params.require(:user).permit(:first_name, :last_name, :birthdate, :avatar)
  end

  def update_profile_params
    params.permit(:first_name, :last_name)
  end
end
