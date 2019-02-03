FactoryBot.define do
  factory :comment do
    sequence(:commenter) { |n| "commenter#{n}"}
    body { 'This was really uncalled for' }

    trait :for_article do
      association(:commentable, factory: :article)
    end

    trait :for_picture do
      association(:commentable, factory: :picture)
    end
  end
end
