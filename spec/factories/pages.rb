FactoryGirl.define do
  factory :page do |p|
    p.title {Faker::Lorem.sentence}
    p.text {Faker::Lorem.sentence}
    p.category :blog
    p.state :published
    p.alias {Faker::Lorem.word}
  end
end
