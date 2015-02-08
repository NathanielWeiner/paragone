class AddVoteTotalToArtObjects < ActiveRecord::Migration
  def change
    add_column :art_objects, :vote_total, :integer, default: 0, null: false
  end
end
