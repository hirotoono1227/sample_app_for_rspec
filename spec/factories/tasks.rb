FactoryBot.define do
  factory :task do
    title { 'test_title01' }
    status { 0 }
    user
  end
end
