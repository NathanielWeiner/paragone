class ArtObject < ActiveRecord::Base
  acts_as_votable
  acts_as_commontable

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

	def self.get_artwork_objects
		artwork_objects = TheWalters::ArtObject.all(:Page => 1, :pageSize => 25)['Items']

		artwork_objects.each do |object|
			id = object["ObjectID"]
			num = object["ObjectNumber"]
			ArtObject.create_with(object_number:num).find_or_create_by(object_id: id)
		end

		return artwork_objects
	end
end
