# frozen_string_literal: true

class LandingController < ApplicationController
  skip_before_action :redirect_if_no_house

  def index
    redirect_to house_path(id: current_user.house_id) if current_user.house_id.present?
  end
end
