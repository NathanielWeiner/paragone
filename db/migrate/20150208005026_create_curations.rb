class CreateCurations < ActiveRecord::Migration
  def change
    create_table :curations do |t|
      t.string :title
      t.string :description
      t.references :art_object

      t.timestamps null: false
    end
  end
end
