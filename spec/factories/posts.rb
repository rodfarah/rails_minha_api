FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 10) }
    body { Faker::Lorem.paragraph(sentence_count: 3) }
    draft { false }
    association :user

    # Post as draft
    trait :draft do
      draft { true }
    end

    # Post with specific content for tests
    trait :with_specific_content do
      title { "Título de Teste" }
      body { "Estamos apenas testando um post com este body" }
    end
  end
end
