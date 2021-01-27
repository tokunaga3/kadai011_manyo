FactoryBot.define do
  factory :task do
    name {'task1'}
    content {'task1'}
    deadline {'2021/10/01'}
    status {'着手中'}
    priority {'高'}

    user
    after(:create) do |task|
     create(:label, tasks: [task])
    end
  end
end
