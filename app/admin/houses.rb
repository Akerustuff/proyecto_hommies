# frozen_string_literal: true

ActiveAdmin.register House do
  permit_params :name, :code, :deleted_at

  action_item :close_house, only: :show do
    link_to 'Close House', close_house_admin_house_path(house), method: :get
  end

  member_action :close_house, method: :get do
    house = House.find(params[:id])
    owner_house = User.find_by(owner: true, house_id: house.id)
    owner_house.owner = false
    house.close_house
    owner_house.save
    redirect_to admin_house_path(house), notice: 'The house is closed'
  end
end
