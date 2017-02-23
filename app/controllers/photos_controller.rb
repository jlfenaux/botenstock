class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin
  layout 'admin'
  def index
    @photos = Photo.all
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      render json: { message: "success", fileID: @photo.id }, :status => 200
    else
      render json: { error: @photo.errors.full_messages.join(',')}, :status => 400
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
  end

private
  def photo_params
    params.require(:photo).permit(:file)
  end
end
