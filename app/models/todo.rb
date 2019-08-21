# Class for representing todo data model
class Todo < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :created_by, presence: true
  validates :title, presence: true
end
