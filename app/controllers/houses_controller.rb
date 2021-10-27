# frozen_string_literal: true

class HousesController < ApplicationController
  skip_before_action :redirect_if_no_house, only: %i[new create join join_house]

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)

    respond_to do |format|
      if @house.save
        current_user.house_id = @house.id
        current_user.owner = true
        current_user.save
        format.html { redirect_to @house, notice: 'house was successfully created.' }
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
          format.html { redirect_to @house, notice: 'You are joined successfully.' }
          # format.json { render :show, status: :created, location: @house }
        else
          format.html { render :new, status: :unprocessable_entity }
          # format.json { render json: @house.errors, status: :unprocessable_entity }
        end
        format.js
      end
    end
  end

  def show
    @house = House.find_by(id: params[:id])
  end

  private

  def house_params
    params.require(:house).permit(:name, :code)
  end
end
