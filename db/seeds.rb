require 'faker'

if Page.all.count == 0
  31.times do |i|
    Page.create!(
      title: Faker::Lorem.sentence,
      text: Faker::Lorem.paragraphs(rand(5..10)).map { |p| "<p>#{p}</p>" }.join("\n"),
      category: :blog,
      state: :published,
      slug: Faker::Lorem.word + i.to_s
    )
  end

  8.times do |i|
    Page.create!(
      title: Faker::Lorem.sentence,
      text: Faker::Lorem.paragraphs(rand(5..10)).map { |p| "<p>#{p}</p>" }.join("\n"),
      category: :static,
      state: :published,
      slug: Faker::Lorem.word + (i * 10).to_s
    )
  end

  Page.create!(
    title: 'Обо мне',
    text: Faker::Lorem.paragraphs(rand(5..10)).map { |p| "<p>#{p}</p>" }.join("\n"),
    category: :static,
    state: :published,
    slug: 'about'
  )
  Page.create!(
    title: 'Резюме',
    text: Faker::Lorem.paragraphs(rand(5..10)).map { |p| "<p>#{p}</p>" }.join("\n"),
    category: :static,
    state: :published,
    slug: 'resume'
  )
  Page.create!(
    title: 'Контакты',
    text: Faker::Lorem.paragraphs(rand(5..10)).map { |p| "<p>#{p}</p>" }.join("\n"),
    category: :static,
    state: :published,
    slug: 'contacts'
  )
end

if User.all.count == 0
  User.create!(
    email: 'admin@cherashev.com',
    password: 'qazwsxedc',
    password_confirmation: 'qazwsxedc',
    role: :admin
  )
end
