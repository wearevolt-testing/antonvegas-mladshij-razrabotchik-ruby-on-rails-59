FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    sequence(:published_at) { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    association :user, factory: :user
  end
end
