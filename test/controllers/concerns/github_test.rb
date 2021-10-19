require 'test_helper'

class GithubTest < ActionDispatch::IntegrationTest
  class GithubClass
    include Github
  end

  def setup
    @github = GithubClass.new
    super
  end

  test "get commit time by github api" do
    assert_kind_of Date, @github.get_file_modify_date("kurehajime","shelf_life","README.md") 
    assert_nil @github.get_file_modify_date("kurehajime","shelf_life","DONT_README.md") 
  end

end