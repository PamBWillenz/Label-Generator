require "test_helper"

class ListTest < ActiveSupport::TestCase
  def setup
    @list = List.new(name: "Friends", description: "List of friends")
  end

  test "should be valid" do
    assert @list.valid?
  end

  test "name should be present" do
    @list.name = " "
    assert_not @list.valid?
  end

  test "description should be present" do
    @list.description = " "
    assert_not @list.valid?
  end
end
