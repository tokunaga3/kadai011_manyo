# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "admin",
             email: "admin@example.com",
             password: "111111",
             admin: true,
             )


10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

10.times do |n|
  Task.create!(
    user: User.offset(rand(Task.count)).first,
    name: Faker::Games::Pokemon.name,
    content: Faker::Games::SuperMario.character,
    deadline: "2021/10/01",
    status: "着手中",
    priority: "高",
               )
end

10.times do |n|
  name = Faker::Games::Pokemon.name
  Label.create!(
    name: Faker::Games::Pokemon.name,
  )
end

10.times do |n|
  ids = rand(Task.count)
  unless ids == 0
    TaskLabel.create!(
      task_id:Task.find(ids).id,
      label_id:Label.find(ids).id)
  end
end
