# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :find_event, only: %i[show edit update destroy event_accept event_reject interested_users registered_users show_details post_comment registration_form register show_receipt]
  def new
    @event = Event.new
    @address = EventAddress.new
  end

  def create
    @event = Event.new(event_params.merge(user_id: current_user.id, category_id: params[:category_id], status: 'pending'))
    if @event.save
      flash[:notice] = 'Event Posted'
      redirect_to event_path(@event.id)
    else
      flash[:notice] = 'Event not Posted'
      redirect_to new_event_path
    end
  end

  def index
    if params[:query].present?
      @event = Event.search1(params[:query]).where(status: 'accepted').order(created_at: :desc)
    else
      @event = Event.where(status: 'accepted').order(created_at: :desc)
      @rejected_articles = Event.where('articles.user_id = ? AND articles.status = ?', current_user, 'reject')
    end
  end

  def update
    if @event.update(event_params.merge(user_id: current_user.id, category_id: params[:category_id], status: 'pending'))
      flash[:notice] = 'Event Updated'
      redirect_to event_path(@event)
    else
      render 'edit'
    end
  end

  def destroy
    if @event.user_id == current_user.id
      @event.destroy
      flash[:notice] = 'Event Deleted'
    end
    redirect_to events_path
  end

  def my_event
    @event = Event.where(user_id: current_user.id)
  end

  def show_interest
    @interest = Interest.new
    @interest.user_id = current_user.id
    @interest.event_id = params[:format]
    redirect_to action: 'index' if @interest.save
  end

  def registered_events
    @registered_event = current_user.events
  end

  def event_requests
    @event_requests = Event.where(status: 'pending')
  end

  def event_accept
    @event.status = 'accepted'
    if @event.save
      flash[:notice] = 'Event Accepted'
      redirect_to event_requests_path(@event)
    end
  end

  def event_reject
    @event.status = 'rejected'
    if @event.save
      flash[:notice] = 'Event Rejected'
      redirect_to event_requests_path(@event)
    end
  end

  def interested_users
    @interested_users = @event.interested_users
  end

  def registered_users
    @registered_users = @event.users
  end

  def show_details
    @event_comments = @event.comments
  end

  def post_comment
    @comment = Comment.new(comment: params[:comment], image: params[:image])

    @comment.user_id = current_user.id
    @comment.event_id = @event.id
    redirect_to show_details_path(@event.id) if @comment.save
  end

  def registration_form; end

  def register
    @register = Registration.new(quantity: params[:quantity])

    @register.event_id = @event.id
    @register.user_id = current_user.id
    @register.total_amount = (@event.price * @register.quantity.to_i)
    redirect_to charges_path(@event.id) if @register.save
  end

  def show_receipt
    @registration = Registration.where(event_id: @event.id, user_id: current_user.id)
    respond_to do |format|
      format.html
      format.pdf do
        render template: 'events/show_receipt.html.erb',
               pdf: 'temp',
               layout: 'pdf.html'
      end
    end
  end

  def find_event
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :time, :website, :user_id, :category_id, :status, :price, :size, :image, event_address_attributes: %i[address_line1 address_line2 area city pincode])
  end

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :event_id, :image)
  end

  def registration_params
    params.require(:registration).permit(:quantity, :user_id, :event_id)
  end
end
