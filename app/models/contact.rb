class Contact < ApplicationRecord
  belongs_to :list

  validates :first_name, :last_name, :address_line1, :city, :state, :zip_code, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_address
    [address_line1, address_line2, "#{city}, #{state} #{zip_code}"].compact.join("\n")
  end
end
