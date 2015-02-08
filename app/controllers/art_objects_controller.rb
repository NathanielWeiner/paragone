class ArtObjectsController < ApplicationController
  def index
    @art_objects = ArtObject.get_artwork_objects
    @art_object = ArtObject.new
  end

  def show
    if(params[:id].scan('$').length == 1) #then search
      num = params[:id].to_s.gsub('$','.')
      @art_object = TheWalters::ArtObject.find(num)
      ArtObject.get_artwork_object(@art_object) unless ArtObject.exists?(object_number: num)
      @ao = ArtObject.find_by(object_number: num)
    else #then show from row link
      @art_object = TheWalters::ArtObject.find(params[:id])
      ArtObject.get_artwork_object(@art_object) unless ArtObject.exists?(params[:id])
      @ao = ArtObject.find(params[:id])
      @art_object.append_merge!('score', @ao.score)
    end

    question_prompts = [
      "What is the effect of this work? What purpose might it serve?",
      "How are figures and objects arranged in space within the composition?",
      "What viewpoint does the artist give you? How does it affect your understanding of the image? Does the artist use perspective?",
      "How does this work reflect the culture/society in which it was created?",
      "Do you think this work is naturalistic, idealized, abstract, or some combination? Why?",
      "What about this work do you think you can only see in person?",
      "How do you think the formal characteristics of the work relate to the subject matter?",
      "What do you think the process of this work's creation looked like?",
      "Was this object created to be viewed standing still or in motion?",
      "How does this work relate to other works nearby in the gallery?",
      "What information would you like to learn more about this work?"]

    @random_question = question_prompts[rand(0..10)]
  end

  def create
    art_object = {id: params[:id] }
    render :js => "window.location = '/art_objects/#{art_object[:id].to_s.gsub('.','$')}'"
  end

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

  def tweet_this
    art_object = TheWalters::ArtObject.find(params['theId'])
    if art_object['Geographies'].nil?
      historical_location = "scholars don't know!"
    else
      historical_location = art_object['Geographies'][0]['GeographyTerm']
    end
    title = art_object['Title'][0..30]
    walters = '@walters_museum'
    location = {}
    tweet = "Visiting #{walters} and checking out #{title} from the #{historical_location}!"
    current_user.tweet_to_twitter(tweet, location)
    render nothing: true
  end
end
