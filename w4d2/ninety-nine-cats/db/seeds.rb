# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|
  birth_date = Date.today - (n+1).years
  colors = %w(brown red grey white)
  name = "Cat #{n+1}"
  sex = %w(M F)
  Cat.create!(name: name, sex: sex.sample, color: colors.sample,
              birth_date: birth_date)
end
