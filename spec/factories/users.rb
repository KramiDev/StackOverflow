FactoryGirl.define do

  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
  end

end
