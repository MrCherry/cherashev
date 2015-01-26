# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

if Page.all.count == 0
  31.times do
    Page.create!(
        title: Faker::Lorem.sentence,
        text: Faker::Lorem.paragraphs(rand(5..10)).map{|p| "<p>#{p}</p>"}.join("\n"),
        category: :blog,
        state: :published
    )
  end

  8.times do
    Page.create!(
        title: Faker::Lorem.sentence,
        text: Faker::Lorem.paragraphs(rand(5..10)).map{|p| "<p>#{p}</p>"}.join("\n"),
        category: :static,
        state: :published
    )
  end
end

if User.all.count == 0
  User.create!(
      email: 'cherashev.f@gmail.com',
      password: 'qazwsxedc',
      password_confirmation: 'qazwsxedc',
      role: :admin
  )
end

