class Interest < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :event_id

  after_create :event_details
  def event_details
    EventDetailsMailer.send_details(self).deliver
  end

end
