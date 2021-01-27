# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_digest: password,
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
  ids = rand(Task.count)+1
  TaskLabel.create!(
    task_id:Task.find(ids).id,
    label_id:Label.find(ids).id)
end
# binding.pry

# 10.times do |n|
#   Task_label.create!(task_id:Task.find(n+1).id,label_id:Label.find(n+1))
# end
# #
# 50.times do |index| #boardダミーの作成。
#  Board.create!(
#      user: User.offset(rand(User.count)).first,
#      title: "タイトル#{index}",
#      body: "本文#{index}"
#  )
