# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

abram = Curation.find_or_create_by!( title: "Abram's Curations", description: "His favorite list of art" )
quint = Curation.find_or_create_by!( title: "Quint's Curations", description: "His better favorite list of art")

ids = [15642, 10416, 492, 6997, 27564, 20010, 10681, 37626, 4432, 30663]

artwork_objects = []

ids.each do |id|
  artwork_objects << TheWalters::ArtObject.find(id)
end

artwork_objects.each do |object|
  id = object['ObjectID']
  num = object['ObjectNumber']
  art_object = ArtObject.create_with(object_number: num).find_or_create_by!(id: id)
  abram.art_objects << art_object
end