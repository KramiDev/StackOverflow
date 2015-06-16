class AttachmentsController < ApplicationController
  def destroy
    @attach = Attachment.find(params[:id])
    @attach.attachable_type == 'Question' ? @result = Question.find(@attach.attachable_id) : @result = Answer.find(@attach.attachable_id)
    if current_user.id == @result.user_id
      @attach.destroy ? flash[:notice] = 'Файл удален' : flash[:alert] = 'Не удалось удалить файл'
    end
  end
end
