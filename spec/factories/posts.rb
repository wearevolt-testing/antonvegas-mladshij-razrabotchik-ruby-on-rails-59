FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    association :user, factory: :user
  end
end
