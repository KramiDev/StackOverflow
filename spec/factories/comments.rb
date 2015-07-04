FactoryGirl.define do
  factory :comment do
    body "MyText"
  end

  factory :invalid_comment, class: Comment do
    body nil
  end
end
