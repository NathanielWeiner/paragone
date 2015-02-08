class ArtObjectsController < ApplicationController
  def index
    # binding.pry
    @art_objects = ArtObject.get_artwork_objects
  end

  def show
  	@art_object = TheWalters::ArtObject.find(params[:id])
		ArtObject.get_artwork_object(@art_object) unless ArtObject.exists?(params[:id])
		@ao = ArtObject.find(params[:id])
		@art_object.append_merge!('score', @ao.score)
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
