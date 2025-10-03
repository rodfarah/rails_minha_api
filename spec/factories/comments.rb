FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(sentence_count: 2) }
    association :user
    association :post

    trait :short do
      body { "Ok" }
    end
  end
end
