FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Article #{n}" }
    text { 'Lorem ipsum dolor sit amet...' }
    terms_of_service { true }
    user
  end
end
