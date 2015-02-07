class ArtObject < ActiveRecord::Base
  acts_as_votable
  acts_as_commontable

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
end
