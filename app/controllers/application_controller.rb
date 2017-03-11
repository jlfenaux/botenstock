class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  # before_action :authenticate_user!

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def check_if_admin
    unless current_user && current_user.has_role?(:admin)
      flash[:error] = I18n.t('access_not_granted')
      redirect_to root_url
    end
  end


end
