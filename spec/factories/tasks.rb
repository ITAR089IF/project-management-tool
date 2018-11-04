FactoryBot.define do
  factory :task, class: 'Task' do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }

    project

    trait :with_files do
      transient do
        files_count { 3 }
      end

      after(:build) do |task, evaluator|
        evaluator.files_count.times do
          task.files.attach(FileFactory.random_file)
        end
      end
    end

  end
end
