class Task < ApplicationRecord
  belongs_to :project
  belongs_to :owner, class_name: 'User'

  validates :content, presence: true, length: { minimum: 1 }
end
