# frozen_string_literal: true

class RegisteredMessagesController < ApplicationController
  def new
    @message = RegisteredMessage.new
  end

  def create
    @event = Event.find(params[:id])
    @message = RegisteredMessage.new(message_params)
    @message.event_id = @event.id
    if @message.save
      flash[:notice] = 'Mail Sent'
      redirect_to my_event_path
    else
      flash[:notice] = 'Mail not Sent'
      redirect_to my_event_path
    end
  end

  private

  def message_params
    params.require(:registered_message).permit(:message, :event_id)
  end
end
