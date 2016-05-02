FactoryGirl.define do
  factory :page do |p|
    p.title    {Faker::Lorem.sentence}
    p.text     {Faker::Lorem.sentence}
    p.category {Page.categories.keys.sample}
    p.state    {Page.states.keys.sample}
    p.alias    {Faker::Lorem.word}
  end
end
