# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, :user_id, :time, :date, :description, presence: true
  validate :event_date_cannot_be_in_the_past?
  
  has_one :event_address, dependent: :destroy
  has_one_attached :image
  has_many :interests, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :interested_users, through: :interests, source: :user
  has_many :users, through: :registrations
  has_many :comments, dependent: :destroy
  has_many :messages
  belongs_to :user
  belongs_to :category

  scope :search1, ->(s) { Event.joins(:category).where('title LIKE ? OR description LIKE ? OR category_name LIKE ? ', "%#{s}%", "%#{s}%", "%#{s}%").where(status: 'accepted') }

  accepts_nested_attributes_for :event_address, allow_destroy: true, reject_if: :all_blank


  def event_date_cannot_be_in_the_past?
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end

  def is_interested?(arg1, arg2)
    !Interest.where('event_id LIKE ? AND user_id LIKE ?', "%#{arg1}", "%#{arg2}").empty?
  end

  def is_my_event?(arg1, arg2)
    !Event.where('id LIKE ? AND user_id LIKE ?', "%#{arg1}", "%#{arg2}").empty?
  end

  def is_registered?(arg1, arg2)
    !Registration.where('event_id LIKE ? AND user_id LIKE ?', "%#{arg1}", "%#{arg2}").empty?
  end

  def self.delete_event
    temp = Event.where(date: Date.today)
    temp.destroy_all
  end 
end
