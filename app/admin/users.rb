# frozen_string_literal: true

ActiveAdmin.register User do
  actions :all

  action_item :reset_user, only: :show do
    link_to 'Reset User', reset_user_admin_user_path(user), method: :get
  end

  member_action :reset_user, method: :get do
    user = User.find(params[:id])
    tasks = Task.where(owner_id: user.id)
    owner_house = User.find_by(owner: true, house_id: user.house_id)
    if owner_house.id == user.id
      redirect_to admin_user_path(user), notice: 'This user is an owner'
    else
      tasks.each do |task|
        user.unassign_tasks
        task.owner_id = owner_house.id
        task.save
      end
      user.house_id = nil
      user.save
      redirect_to admin_user_path(user), notice: 'The user has been reseted successfully'
    end
  end

  permit_params :email, :first_name, :last_name, :owner, :house_id, :birthdate, :admin
end
