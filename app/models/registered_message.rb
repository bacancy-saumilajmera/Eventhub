# frozen_string_literal: true

class RegisteredMessage < ApplicationRecord
  belongs_to :event
  validates :message, presence: true

  after_create :send_message
  def send_message
    RegisteredMessageMailer.send_message(self).deliver
  end
end
