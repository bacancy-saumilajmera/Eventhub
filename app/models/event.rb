class Event < ApplicationRecord
  has_one :event_address ,:dependent => :destroy
  has_many :interests
  has_many :users, through: :interests
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true 
  validates :time, presence: true
  validates :user_id , presence: true

  accepts_nested_attributes_for :event_address, allow_destroy: true, :reject_if => :all_blank
end
