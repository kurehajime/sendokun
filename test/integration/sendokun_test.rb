require 'test_helper'

class SendkunTest < ActionDispatch::IntegrationTest
  test "fail params" do
    # no params
    get "/"
    assert_includes response.body , "error"

    # no repo
    get "/?yyyymmdd=20210101&user=kurehajime&repo=sendochan"
    assert_includes response.body , "error"

    # fail date
    get "/?yyyymmdd=20210229&user=kurehajime&repo=sendokun"
    assert_includes response.body , "error"

    # no file
    get "/?yyyymmdd=20210101&user=kurehajime&repo=sendokun&path=DO_NOT_README.md"
    assert_includes response.body , "error"
  end

  test "success" do
    # repo only
    get "/?yyyymmdd=20010101&user=kurehajime&repo=sendokun"
    assert_includes response.body , "stale"

    # stale
    get "/?yyyymmdd=20010101&user=kurehajime&repo=sendokun&path=README.md"
    assert_includes response.body , "stale"

    # fresh
    get "/?yyyymmdd=20991231&user=kurehajime&repo=sendokun&path=README.md"
    assert_includes response.body , "fresh"
  end

end