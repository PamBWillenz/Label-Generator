class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.references :list, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.boolean :active

      t.timestamps
    end
  end
end
