require './test/test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    # Wykonuje się przed KAŻDYM (osobno) przypadkiem testowym
    @article = create :article
    @user = create :user
  end

  teardown do
    # Wykonuje się PO każdym przypadku testowym
  end

  test 'GET #index shows artticles' do
    get articles_path
    assert_response :success
    assert_includes(assigns[:articles], @article)
    assert_template 'index'
  end

  test 'POST #create when not signed in' do
    post articles_path, params: {
      article: { title: 'test title', text: 'texttexttext',
                terms_of_service: '1' }
    }
    assert_redirected_to new_user_session_path
  end

  test 'POST #create when signed in' do
    sign_in @user
    assert_difference 'Article.count', 1 do
      post articles_path, params: {
        article: { title: 'test title', text: 'texttexttext',
                    terms_of_service: '1' }
    }
    end
    assert_redirected_to articles_path(Article.last)
  end
end
