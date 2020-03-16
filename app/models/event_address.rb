# frozen_string_literal: true

class EventAddress < ApplicationRecord
  belongs_to :event
  validates_presence_of :event
  validates :address_line1, presence: true
  validates :address_line2, presence: true
  validates :area, presence: true
  validates :city, presence: true
end
