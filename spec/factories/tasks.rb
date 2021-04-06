FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "test_title#{n}" }
    content { 'test_content' }
    status { 0 }
    deadline { '2020-12-31 12:00:00' }
    user
  end
end
