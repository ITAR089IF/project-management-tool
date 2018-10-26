# == Schema Information
#
# Table name: user_projects
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_user_projects_on_project_id  (project_id)
#  index_user_projects_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe UserProject, type: :model do
  it { expect(create(:user)).to be_persisted }
end
