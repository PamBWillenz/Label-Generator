# Clear existing data
List.destroy_all
Contact.destroy_all

# Create sample lists
list1 = List.create(name: 'Friends', description: 'List of friends')
list2 = List.create(name: 'Family', description: 'List of family members')

# Create sample contacts for list1
list1.contacts.create([
  { first_name: 'John', last_name: 'Doe', address_line1: '123 Main St', address_line2: '', city: 'Anytown', state: 'CA', zip_code: '12345', country: 'USA', active: true },
  { first_name: 'Jane', last_name: 'Smith', address_line1: '456 Oak St', address_line2: 'Apt 2', city: 'Othertown', state: 'NY', zip_code: '67890', country: 'USA', active: true }
])

# Create sample contacts for list2
list2.contacts.create([
  { first_name: 'Alice', last_name: 'Johnson', address_line1: '789 Pine St', address_line2: '', city: 'Sometown', state: 'TX', zip_code: '54321', country: 'USA', active: true },
  { first_name: 'Bob', last_name: 'Brown', address_line1: '101 Maple St', address_line2: 'Suite 100', city: 'Anycity', state: 'FL', zip_code: '98765', country: 'USA', active: true }
])

# Create a Holiday list with 20 sample contacts
list3 = List.create(name: 'Holiday', description: 'List of holiday contacts')

20.times do |i|
  list3.contacts.create(
    first_name: "HolidayFirstName#{i+1}",
    last_name: "HolidayLastName#{i+1}",
    address_line1: "#{i+1} Holiday St",
    address_line2: '',
    city: 'HolidayCity',
    state: 'HC',
    zip_code: "1234#{i+1}",
    country: 'USA',
    active: true
  )
end
