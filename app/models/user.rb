class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, foreign_key: 'owner_id'
  has_many :tasks, foreign_key: 'owner_id'

  after_create do
    inbox = Project.create!(owner_id: id, name: 'Inbox', order: 0)
    User.find(id).update!(inbox_id: inbox.id)
  end
end
