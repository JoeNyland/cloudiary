FactoryBot.define do
  factory :user do
    name { Faker::TvShows::FamilyGuy.character }
    email { Faker::Internet.email name: name }
    password { Faker::Internet.password min_length: 6 }
  end
end
