# frozen_string_literal: true

class LandingController < ApplicationController
  skip_before_action :redirect_if_no_house

  def landing_page
    redirect_to landing_without_house_path if user_signed_in? && current_user.house_id.nil?
    redirect_to house_path(id: current_user.house_id) if user_signed_in? && current_user.house_id.present?
  end

  def without_house; end
end
