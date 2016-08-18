FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password 'password'
    role :user
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin-#{n}@example.com" }
    password 'password'
    role :admin
  end
end