FactoryGirl.define do
  factory :page do
    title {Faker::Lorem.sentence}
    text {Faker::Lorem.sentence}
    category :blog
    state :published
  end
end