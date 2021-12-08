# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!

  def google_oauth2
    user = create_user_from_google

    if user.present?
      sign_out_all_scopes
      flash[:success] = t('devise.omniauth_callbacks.success', kind: 'Google')
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = t('devise.omniauth_callbacks.failure',
                        kind: 'Google',
                        reason: "#{auth.info.email} is not authorized.")
      redirect_to new_user_session_path
    end
  end

  private

  def create_user_from_google
    oauth_params = {
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name
    }

    User.create_with(oauth_params).find_or_create_by!(email: auth.info.email)
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
