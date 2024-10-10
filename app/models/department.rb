class Department < ApplicationRecord
  has_many :users
  has_many :tickets
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
