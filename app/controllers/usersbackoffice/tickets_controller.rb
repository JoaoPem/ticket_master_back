class Usersbackoffice::TicketsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ticket, only: %i[ show update destroy ]

  def index
    @tickets = Ticket.accessible_by(current_ability)
    render json: @tickets
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.creator = @current_user
    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @ticket
  end

  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

    # DELETE /tickets/:id
    def destroy
      @ticket.destroy
      head :no_content
    end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :status, :priority, :department_id, :deadline_date, :deadline_time, :requester_id, :assigned_user_id)
  end
end
