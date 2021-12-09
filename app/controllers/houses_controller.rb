# frozen_string_literal: true

class HousesController < ApplicationController
  skip_before_action :redirect_if_no_house, only: %i[new create join join_house]
  before_action :set_house, only: %i[show]

  def new
    @house = House.new
  end

  def show
    @q = @house.house_tasks(current_user).ransack(params[:q])
    @house_tasks = @q.result(distinct: true)
  end

  def create
    @house = House.new(house_params)

    respond_to do |format|
      if @house.save
        current_user.house_id = @house.id
        current_user.owner = true
        current_user.save
        format.html { redirect_to @house, notice: 'la casa ha sido creada con èxito.' }
        format.json { render :show, status: :created, location: @house }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  def join; end

  def join_house
    @house = House.find_by(code: params[:code])
    if @house.blank?
      redirect_to join_path(notice: 'El codigo de la casa es incorrecto.')
    else
      respond_to do |format|
        current_user.house_id = @house.id
        if current_user.save
          format.html { redirect_to @house, notice: 'Te has unido a la casa.' }
          # format.json { render :show, status: :created, location: @house }
        else
          format.html { render :new, status: :unprocessable_entity }
          # format.json { render json: @house.errors, status: :unprocessable_entity }
        end
        format.js
      end
    end
  end

  def leave_house
    @house = House.find_by(id: current_user.house_id)
    current_user.change_ownership_tasks
    current_user.unassign_tasks
    current_user.house_id = nil
    respond_to do |format|
      if current_user.save
        format.html { redirect_to landing_without_house_path, notice: 'Has dejado la casa.' }
        # format.json { render :show, status: :created, location: @house }
      else
        format.html { redirect_to landing_without_house_path, status: :unprocessable_entity }
        # format.json { render json: @house.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  def destroy
    if current_user.owner?
      @house = House.find_by(id: current_user.house_id)
      @house.close_house
      current_user.owner = false
      current_user.save
      @house.destroy
      respond_to do |format|
        format.html { redirect_to landing_without_house_path, notice: 'La casa ha sido eliminada.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_profile_path, notice: 'No eres el dueño de la casa.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.require(:house).permit(:name, :code, :q)
  end
end
