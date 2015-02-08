class CreateArtObjectsCurations < ActiveRecord::Migration
  def change
    create_table :art_objects_curations, id: false do |t|
      t.integer :art_object_id
      t.integer :curation_id
    end
  end
end
