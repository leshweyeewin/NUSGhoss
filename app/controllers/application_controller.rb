require 'will_paginate/array'

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :site_search
  helper_method :popular_tags

  def site_search
    @q = Status.ransack(params[:q])
    @q_statuses = @q.result(distinct:true).includes(:tags).order("created_at DESC")
  end

  def popular_tags
    ActsAsTaggableOn::Tag.most_used(10).where.not(:taggings_count => 0)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:profile_name, :ivle_id, :ivle_name, :email, :password, :password_confirmation, :remember_me, :image) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:profile_name, :ivle_id, :ivle_name, :email, :password, :remember_me, :image) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:profile_name, :email, :password, :password_confirmation, :current_password, :image) }
  end
end
