# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  about                  :text
#  dashboard_layout       :json
#  deleted_at             :datetime
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
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryBot.define do
  factory :user, aliases: [:creator] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |index| Faker::Internet.email.sub(/\@/, "_#{index}@") }
    password { Faker::Internet.password }
    job_role { Faker::Job.title }
    department { Faker::Job.field }
    about { Faker::Lorem.sentence }
  end

  trait :admin do
    role { "admin" }
  end

  trait :with_workspaces do
    after(:create) do |user|
      FactoryBot.create_list(:workspace, 6, user: user)
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
          FactoryBot.create(:task, :future, project: project, creator: user)
          FactoryBot.create(:task, :expired, project: project, creator: user)
          FactoryBot.create(:task, :completed, :expired, completed_by: user, project: project, creator: user)
          FactoryBot.create_list(:task, rand(10), project: project, creator: user)
          FactoryBot.create_list(:task, rand(10), :completed_in_range, project: project, assignee: user, creator: user)
          FactoryBot.create_list(:task, rand(10), :completed_in_range, project: project, creator: user)
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

  trait :with_member_assignee do
    after(:create) do |user|
      user.workspaces.each do |workspace|
        workspace.shared_workspaces.create(workspace_id: workspace.id, user_id: User.second.id)
        workspace.projects.each do |project|
          workspace.members.each do |member|
            project.tasks.incomplete.limit(5).each do |task|
              task.update(assignee: member, completed_at: Date.today, completed_by_id: member.id)
            end
          end
        end
      end
    end
  end
end
