require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validation tests' do
    let!(:user) { create(:user) }
    let!(:project) { create(:project, user_id: user.id) }
    let!(:task) { build(:task, project_id: project.id) }

     it { should validate_presence_of(:title) }

     it { should validate_presence_of(:description) }

     it { should belong_to(:project) }
 
     it { should validate_length_of(:title).is_at_most(250) }

     it { should validate_length_of(:description).is_at_most(250) }
  end
end
