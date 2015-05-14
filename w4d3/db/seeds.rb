# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  user_name: "Velina",
  password_digest: BCrypt::Password.create("password")
)

Cat.create!(
  birth_date: 2.years.ago,
  color: "brown",
  name: "A-aron",
  sex: "M",
  user_id: User.find_by(user_name: "Velina").id
)

CatRentalRequest.create!(
  cat_id: Cat.find_by(name: "A-aron").id,
  start_date: 1.year.ago,
  end_date: 2.months.ago,
  user_id: 1
)

CatRentalRequest.create!(
  cat_id: Cat.find_by(name: "A-aron").id,
  start_date: 2.year.ago,
  end_date: 6.months.ago,
  user_id: 1
)
