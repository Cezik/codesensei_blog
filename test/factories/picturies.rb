FactoryBot.define do
  factory :picture do
    sequence(:title) { |n| "Picture #{n}" }
    description { 'Artsy fartsy pic' }
    image do
      Rack::Test::UploadedFile.new(Rails.root.join('test/support/testimg.jpg'), 'image/jpeg')
    end
    article
  end
end
