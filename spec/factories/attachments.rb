FactoryGirl.define do
  factory :attachment do
    file ActionDispatch::Http::UploadedFile.new(tempfile: File.new("#{Rails.root}/spec/rails_helper.rb"), filename: "rails_helper.rb")
  end
end
