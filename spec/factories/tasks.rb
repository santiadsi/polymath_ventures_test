FactoryBot.define do
  factory :task do
    description { Faker::Lorem.paragraph }
    complete { false }
    user
  end
end
