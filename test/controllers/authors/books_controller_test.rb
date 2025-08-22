require "test_helper"

class Authors::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get authors_books_index_url
    assert_response :success
  end
end
