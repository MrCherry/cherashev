FactoryGirl.define do
  factory :file_upload do
    original_file_name {"#{Faker::Lorem.word}.jpg"}
    file_name {SecureRandom.hex(16)}
    file_type {%w(image/jpeg image/png image/bmp application/zip).sample}
  end
end
