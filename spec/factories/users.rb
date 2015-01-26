FactoryGirl.define do
  factory :user do
    email {Faker::Internet.safe_email}
    password = Faker::Internet.password(8)
    password {password}
    password_confirmation {password}
  end

  factory :admin_user do
    email {Faker::Internet.safe_email}
    password = Faker::Internet.password(8)
    password {password}
    password_confirmation {password}
    role :admin
  end

end
