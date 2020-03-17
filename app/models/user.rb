# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  has_many :interests, dependent: :destroy
  has_many :events, through: :interests
  has_many :registrations, dependent: :destroy
  has_many :events, through: :registrations
  has_many :comments
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :firstname, :password, :contact_no, :username, :lastname, presence: true

  def is_admin?(user_id)
    user = User.find(user_id)
    if (user.roles[0].name == 'admin') || (user.roles[0].name == 'super_admin')
      true
    else
      false
    end
  end

  after_create :welcome_send, :welcome_notification, :add_user_role
  def welcome_send
    WelcomeMailer.signup_confirmation(self).deliver
  end

  def add_user_role
    add_role(:user) if roles.blank?
  end

  def welcome_notification
    Notification.create(user_id: User.last.id, notification_message: 'Welcome to Eventhub', status: false)
   end
end
