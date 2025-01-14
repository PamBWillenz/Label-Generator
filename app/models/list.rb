class List < ApplicationRecord
  has_many :contacts, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
end
