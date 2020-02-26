class User < ApplicationRecord
  rolify
  has_many :interests
  has_many :events, through: :interests
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :username, presence: true
  validates :contact_no, presence: true
  validates :password, presence: true

  after_create :welcome_send
  def welcome_send
    WelcomeMailer.signup_confirmation(self).deliver
  end
end
