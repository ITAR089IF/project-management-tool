require 'rails_helper'

RSpec.describe Account::SearchController, type: :controller do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  it 'should be success' do
    get :index

    expect(response).to be_successful
  end

  it 'should return json' do
    get :index, params: { search: 'work' }

    expect(JSON.parse(response.body)).to be_include('workspaces')
    expect(JSON.parse(response.body)).to be_include('projects')
    expect(JSON.parse(response.body)).to be_include('tasks')
  end
end
