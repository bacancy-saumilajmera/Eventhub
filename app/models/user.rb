# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :login_social
  rolify
  has_many :interests, dependent: :destroy
  has_many :events, through: :interests
  has_many :registrations, dependent: :destroy
  has_many :events, through: :registrations
  has_many :comments
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,:omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :name, :password, presence: true, unless: :login_social
  

  def is_admin?(arg)
    arg.has_role? :admin
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

   def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.skip_confirmation!
      user.login_social = true
    end
  end
end
