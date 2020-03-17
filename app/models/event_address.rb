# frozen_string_literal: true

class EventAddress < ApplicationRecord
  belongs_to :event
  validates_presence_of :event
  validates :address_line1, :address_line2, :area, :city, presence: true
end
