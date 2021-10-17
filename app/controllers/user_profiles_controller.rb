# frozen_string_literal: true

class UserProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit; end
end
