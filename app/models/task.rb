class Task < ApplicationRecord
  include TasksHelper

  belongs_to :project
  belongs_to :owner, class_name: 'User'

  validates :content, presence: true, length: { minimum: 1 }

  scope :completed, -> { where('completed = ?', true) }
  scope :not_completed, -> { where('completed = ?', false) }
  scope :overdue, -> { not_completed.where('target_date < ?', Time.now.beginning_of_day) }
  scope :today, lambda {
                  not_completed.where('target_date >= ?', Time.now.beginning_of_day)
                               .and(where('target_date <= ?', Time.now.end_of_day))
                }
end
