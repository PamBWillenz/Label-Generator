require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list = lists(:one)
    @contact = contacts(:one)
  end

  test "should get new" do
    get new_list_contact_url(@list)
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post list_contacts_url(@list), params: { contact: { first_name: 'John', last_name: 'Doe', address_line1: '123 Main St', city: 'Anytown', state: 'CA', zip_code: '12345' } }
    end

    assert_redirected_to preview_contacts_list_url(@list)
  end

  test "should get edit" do
    get edit_list_contact_url(@list, @contact)
    assert_response :success
  end

  test "should update contact" do
    patch list_contact_url(@list, @contact), params: { contact: { first_name: 'Jane' } }
    assert_redirected_to preview_contacts_list_url(@list)
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete list_contact_url(@list, @contact)
    end

    assert_redirected_to preview_contacts_list_url(@list)
  end
end
