# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 5.times do |i|
#   User.create(
#           email: "supersem#{i}@asana.com",
#           password: '123456',
#           full_name: Faker::Name.name
#   )
# end
#
# User.all.each do |user|
#   Faker::Number.between(5, 10).times do |i|
#     user.projects.create(name: Faker::Name.name)
#   end
# end
#
# Project.all.each do |project|
#   Faker::Number.between(5, 10).times do |i|
#     project.tasks.create(title: Faker::Name.name, description: Faker::Lorem.paragraph)
#   end
# end

Project.all.each do |project|
  Faker::Number.between(2,5).times do |i|
    project.comments.create(body: Faker::Lorem.paragraph, user_id: rand(User.all.count))
  end
end

Task.all.each do |task|
  Faker::Number.between(2,5).times do |i|
    task.comments.create(body: Faker::Lorem.paragraph, user_id: rand(User.all.count))
  end
end
