class Photos::LikesController < ApplicationController
  before_action :get_photo

  def create
    @photo.photo_likes.find_or_create_by user: current_user
    render_response
  end

  def destroy
    @photo.photo_likes.find_by(user: current_user)&.destroy
    render_response
  end

  private

  def get_photo
    @photo = Photo.find params[:photo_id]
  end

  def render_response
    respond_to do |format|
      format.turbo_stream { render "update" }
      format.html { redirect_to root_path }
    end
  end
end
