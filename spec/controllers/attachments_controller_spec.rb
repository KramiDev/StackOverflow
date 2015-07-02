require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  sign_in_user

  let(:question) { create(:question, user: @user) }

  describe "DELETE #destroy" do
    before do
      question.attachments.create(attributes_for(:attachment))
    end

    it "Author delete file from question" do
      expect { delete :destroy, id: question.attachments[0], format: :js }.to change(Attachment, :count).by(-1)
    end

    it 'Render template attachments/destroy' do
      delete :destroy, id: question.attachments[0], format: :js
      expect(response).to render_template 'attachments/destroy'
    end
  end
end
