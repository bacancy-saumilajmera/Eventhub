class Event < ApplicationRecord
  has_one :event_address ,:dependent => :destroy
  has_one_attached :image
  has_many :interests
  has_many :comments
  has_many :users, through: :interests
  has_many :messages
  belongs_to :user
  belongs_to :category
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true 
  validates :time, presence: true
  validates :user_id , presence: true
  validate :event_date_cannot_be_in_the_past?

  def event_date_cannot_be_in_the_past?
   if date.present? && date < Date.today
     errors.add(:date, "can't be in the past")
   end
  end
  scope :search1, -> (s){ Event.joins(:category).where("title LIKE ? OR description LIKE ? OR category_name LIKE ? ","%#{s}%","%#{s}%","%#{s}%") }

  accepts_nested_attributes_for :event_address, allow_destroy: true, :reject_if => :all_blank
end
