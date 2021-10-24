require 'test_helper'

class GithubTest < ActionDispatch::IntegrationTest
  class GithubClass
    include Github
  end

  def setup
    @github = GithubClass.new
    super
  end

  test "get modify file  time by github api" do
    assert_kind_of Date, @github.get_file_modify_date("kurehajime","sendokun","master","README.md") 
    assert_nil @github.get_file_modify_date("kurehajime","sendokun","master","DONT_README.md") 
    assert_nil @github.get_file_modify_date("kurehajime","sendokun","doctor","README.md") 
  end

end