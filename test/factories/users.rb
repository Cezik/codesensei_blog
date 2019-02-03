FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@codesensei.pl" }
    password { 'p@55w0rd' }
    role { 'user' }

    trait :admin do
      role { 'admin' }
    end

    trait :editor do
      role { 'editor' }
    end
  end
end
