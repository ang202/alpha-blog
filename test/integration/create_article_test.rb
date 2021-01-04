require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: 'Johnny', email:"johnny@gmail.com", password:"password123")
    @category = Category.create(name: "Travel")
    @category2 = Category.create(name: "Sports")
    sign_in_as(@user)
  end

  test "should create a new article" do
    get '/articles/new'
    assert_response :success
    assert_difference('Article.count',1) do
      post articles_path, params:{article:{title: "this can be some title", description: "this is a short description", category_ids:[1,2]}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'this can be some title',response.body
  end
end
