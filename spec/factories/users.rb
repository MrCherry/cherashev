FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password = Faker::Internet.password(8)
    password {password}
    password_confirmation {password}
  end

end
