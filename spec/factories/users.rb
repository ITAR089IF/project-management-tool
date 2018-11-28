# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  about                  :text
#  department             :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  job_role               :string
#  last_name              :string
#  oauth_expires_at       :string
#  oauth_token            :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("user")
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |index| Faker::Internet.email.sub(/\@/, "_#{index}@") }
    password { Faker::Internet.password }
    job_role { Faker::Job.title }
    department { Faker::Job.field }
    about { Faker::Lorem.sentences }
  end

  trait :admin do
    role { "admin" }
  end

  trait :with_workspaces do
    after(:create) do |user|
      FactoryBot.create_list(:workspace, 2, user: user)
    end
  end

  trait :with_projects do
    after(:create) do |user|
      user.workspaces.each do |workspace|
        FactoryBot.create_list(:project, 2, workspace: workspace, users: [user])
      end
    end
  end

  trait :with_comments_for_projects do
    after(:create) do |user|
      user.workspaces.each do |workspace|
        workspace.projects.each do |project|
          project.update(users: [user])
          FactoryBot.create_list(:comment, rand(5), :for_project, user: user, commentable: project)
        end
      end
    end
  end

  trait :with_tasks do
    after(:create) do |user|
      user.workspaces.each do |workspace|
        workspace.projects.each do |project|
          FactoryBot.create(:task, :future, project: project)
          FactoryBot.create(:task, :expired, project: project)
          FactoryBot.create_list(:task, 100, :in_range, project: project, completed_by_id: user.id)
          FactoryBot.create(:task, :completed, :expired, project: project, completed_by_id: user.id)
        end
      end
    end
  end

  trait :with_comments_for_tasks do
    after(:create) do |user|
      user.workspaces.each do |workspace|
        workspace.projects.each do |project|
          project.tasks.each do |task|
            project.update(users: [user])
            FactoryBot.create_list(:comment, rand(5), :for_task, user: user, commentable: task)
          end
        end
      end
    end
  end

  trait :with_watchers do
    after(:create) do |user|
      user.workspaces.each do |workspace|
        workspace.projects.each do |project|
          project.tasks.each do |task|
            task.update(watchers: [user])
          end
        end
      end
    end
  end
end
