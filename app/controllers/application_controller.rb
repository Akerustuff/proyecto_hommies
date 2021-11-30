# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: %i[landing_page without_house]

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_if_no_house
  skip_before_action :redirect_if_no_house, if: :devise_controller?

  protected

  def redirect_if_no_house
    redirect_to landing_without_house_path if user_signed_in? && current_user.house_id.nil?
  end

  def authenticate_admin!
    redirect_to house_path(id: current_user.house_id), alert: 'No eres un administrador' unless current_user.admin?
  end

  def landing_page; end

  def without_house; end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name owner birthdate avatar])
    devise_parameter_sanitizer.permit(:user_profile_update,
                                      keys: %i[first_name last_name birthdate avatar])
  end
end
