FactoryBot.define do
  factory :entry do
    body { Faker::Lorem.sentences(number: 5) }
    user
  end
end
