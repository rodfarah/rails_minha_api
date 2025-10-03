FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    password_confirmation { "password123" }
    is_active { true }
    role { :user }
    gender { :male }

    # Factory for Admin user
    trait :admin do
      role { :admin }
    end

    # Factory for inative user
    trait :inactive do
      is_active { false }
    end

    # Factory for different genders
    trait :female do
      gender { :female }
    end
  end
end
