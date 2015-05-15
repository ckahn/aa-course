# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  email: "chris@email.com",
  password_digest: BCrypt::Password.create("password")
)

10.times do |n|
  Band.create!(name: "Band-#{n + 1}")
end

Band.all.each.with_index do |band|
  2.times do |n|
    Album.create!(
      band_id: band.id,
      name: "#{band.name}'s album #{n + 1}",
      live: [true, false].sample
    )
  end
end

Album.all.each do |album|
  10.times do |n|
    Track.create!(
      album_id: album.id,
      name: "Track-#{n + 1}",
      bonus_track: [true, false].sample
    )
  end
end
