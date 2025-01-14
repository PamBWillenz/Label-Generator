require "test_helper"

class ContactTest < ActiveSupport::TestCase
  def setup
    @list = lists(:one)
    @contact = @list.contacts.build(
      first_name: "John",
      last_name: "Doe",
      address_line1: "123 Main St",
      city: "Anytown",
      state: "CA",
      zip_code: "12345"
    )
  end

  test "should be valid" do
    assert @contact.valid?
  end

  test "first name should be present" do
    @contact.first_name = " "
    assert_not @contact.valid?
  end

  test "last name should be present" do
    @contact.last_name = " "
    assert_not @contact.valid?
  end

  test "address_line1 should be present" do
    @contact.address_line1 = " "
    assert_not @contact.valid?
  end

  test "city should be present" do
    @contact.city = " "
    assert_not @contact.valid?
  end

  test "state should be present" do
    @contact.state = " "
    assert_not @contact.valid?
  end

  test "zip_code should be present" do
    @contact.zip_code = " "
    assert_not @contact.valid?
  end
end
