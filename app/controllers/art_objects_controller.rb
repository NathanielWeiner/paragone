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

  # def upvote
  #   @art_object = ArtObject.find(params[:id])
  #   @art_object.upvote_by(current_user)
  #   redirect_to(art_objects_path)
  # end

  def upvote
    @art_object = ArtObject.find(params[:id])
    respond_to do |format|
    unless current_user.voted_for? @art_object
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js { render :layout => false }
      @art_object.vote_total = @art_object.vote_total + 1
      @art_object.save
      @art_object.upvote_by current_user
    else
      flash[:danger] = 'You allready voted for this entry'
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js
    end
   end
  end

  # def downvote
  #   @art_object = ArtObject.find(params[:id])
  #   @art_object.downvote_by(current_user)
  #   redirect_to(art_objects_path)
  # end

  def downvote
  @art_object = ArtObject.find(params[:id])
  respond_to do |format|
  unless current_user.voted_for? @art_object
    format.html { redirect_to :back }
    format.json { head :no_content }
    format.js { render :layout => false }
    @art_object.vote_total = @art_object.vote_total + 1
    @art_object.save
    @art_object.downvote_by current_user
  else
    flash[:danger] = 'You allready voted for this entry'
    format.html { redirect_to :back }
    format.json { head :no_content }
    format.js
  end
 end
end
end
