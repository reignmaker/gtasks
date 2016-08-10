FactoryGirl.define do
  factory :task do
    name "MyString"
    description "MyText"
    user nil
    state 1
  end
end
