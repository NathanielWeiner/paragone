class ArtObjectsController < ApplicationController
  def index
    # binding.pry
    @art_objects = ArtObject.get_artwork_objects
  end

  def show
  end

  def upvote
    @art_object = ArtObject.find(params[:id])
    @art_object.upvote_by(current_user)
    redirect_to(art_objects_path)
  end

  def upvote
    @art_object = ArtObject.find(params[:id])
    @art_object.downvote_by(current_user)
    redirect_to(art_objects_path)
  end
end
