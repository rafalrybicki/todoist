class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true, length: { minimum: 1 }
end
