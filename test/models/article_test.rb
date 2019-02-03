require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:text)
  should validate_length_of(:title).is_at_least(5).is_at_most(40)
  should validate_acceptance_of(:terms_of_service)

  test 'should strip html tags on validation' do
    article = build :article, text: 'This <b>is</b> a mess!'
    assert_predicate article, :valid?
    assert_equal 'This is a mess!', article.text
  end
end
