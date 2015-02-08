class ArtObject < ActiveRecord::Base

  has_and_belongs_to_many :curations

  acts_as_votable
  acts_as_commontable

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  def self.get_artwork_objects
    artwork_objects = TheWalters::ArtObject.all(:Page => 2, :pageSize => 25)['Items']

    artwork_objects.each do |object|
      id = object['ObjectID']
      num = object['ObjectNumber']
      art_object = ArtObject.create_with(object_number: num).find_or_create_by(id: id)
      object.append_merge!('score', art_object.score)
    end
    # binding.pry
    return artwork_objects
  end
end
