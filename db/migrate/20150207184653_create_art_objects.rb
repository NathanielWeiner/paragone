class CreateArtObjects < ActiveRecord::Migration
  def change
    create_table :art_objects do |t|
      t.integer :object_id
      t.string :object_number

      t.timestamps null: false
    end
  end
end
