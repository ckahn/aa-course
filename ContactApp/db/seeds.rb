# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |n|
  User.create!(username: "User #{n + 1}")
end

User.all.each do |user|
  5.times do |n|
    Contact.create!(
      name: "Contact #{n + 1}",
      email: "Email #{n + 1}",
      user_id: user.id
    )
    user.comments.create!(
      author_id: (user.id + 1) % 5,
      body: "This is comment #{n + 1} on user #{user.id}"
    )
  end
end

5.times do |n|
  ContactShare.create!(
    user_id: (n+1),
    contact_id: (5 * (n+1) + 1) % 25
  )
end
