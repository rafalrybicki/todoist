class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :owner, class_name: 'User'
end
