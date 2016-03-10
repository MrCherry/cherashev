FactoryGirl.define do
  factory :file_upload do
    original_file_name {"#{Faker::Lorem.word}.jpg"}
    file_name {Digest::MD5.hexdigest(Time.zone.now.to_s)}
    file_type "image/jpeg"
  end
end
