FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'wonderfulemail@test.com' }
    password { 'password' }
  end
end
