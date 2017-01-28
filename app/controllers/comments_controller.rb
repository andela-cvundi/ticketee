class CommentsController < ApplicationController
  before_action :find_ticket

  def create
    whitelisted_params = comment_params

    unless policy(@ticket).change_state?
      whitelisted_params.delete(:state_id)
    end

    @comment = @ticket.comments.build(whitelisted_params)
    @comment.user = current_user
    authorize @comment, :create?

    if @comment.save
      flash[:notice] = "Comment has been created."
      notify_watchers
      redirect_to [@ticket.project, @ticket]
    else
      flash.now[:alert] = "Comment has not been created."
      @project = @ticket.project
      render "tickets/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :state_id)
  end

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def notify_watchers
    (@comment.ticket.watchers - [@comment.user]).each do |user|
      CommentNotifierMailer.created(@comment, user).deliver_now
    end
  end

end
