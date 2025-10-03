FactoryBot.define do
  factory :comments do
    text { Faker::Lorem.paragraph(sentence_count: 2) }
    association :user
    association :post

    trait :short do
      body { "Ok" }
    end
  end
end
