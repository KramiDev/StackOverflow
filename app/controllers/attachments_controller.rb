class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  respond_to :js, only: [:destroy]

  authorize_resource

  def destroy
    @attach = Attachment.find(params[:id])
    @attach.attachable_type == 'Question' ? @result = Question.find(@attach.attachable_id) : @result = Answer.find(@attach.attachable_id)
    respond_with(@attach.destroy)
  end
end
