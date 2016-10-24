# frozen_string_literal: true
class BaseController < ApplicationController
  helper_method :current_collection, :current_object

  def index
  end

  def new
    @current_object = collection_scope.new
  end

  def create
    @current_object = collection_scope.new(resource_params)
    return render action: :new unless @current_object.save
    action_success
  end

  def destroy
    current_object.destroy
    action_success
  end

  def edit
  end

  def update
    if current_object.update(resource_params)
      action_success
    else
      respond_to do |f|
        f.html { return render action: :edit }
        f.json
      end
    end
  end

  private

  def action_success
    respond_to do |f|
      f.html do
        flash[:success] ||= t("success.#{action_name}")
        redirect_to send("url_after_#{action_name}")
      end
      f.json
    end
  end

  # override in controller if needed
  def url_after_create
    request.env["HTTP_REFERER"] || url_for(action: :index)
  end

  def url_after_destroy
    url_for(action: :index)
  end

  alias url_after_update url_after_create

  # You should implement these in your controller
  def collection_scope; end

  def resource_params; end

  def current_collection
    @current_collection ||= collection_scope.page(params[:page])
  end

  def current_object
    @current_object ||= collection_scope.find(params[:id])
  end
end
