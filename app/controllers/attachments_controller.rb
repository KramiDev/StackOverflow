class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  respond_to :js, only: [:destroy]

  authorize_resource

  def destroy
    @attach = Attachment.find(params[:id])
    @attach.attachable_type == 'Question' ? @result = Question.find(@attach.attachable_id) : @result = Answer.find(@attach.attachable_id)
    if current_user.id == @result.user_id
      respond_with(@attach.destroy)
    else
      redirect_to @result
    end
  end
end
