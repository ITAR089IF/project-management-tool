require 'rails_helper'

RSpec.describe Account::SearchController, type: :controller do
  render_views

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

    parsed_response = JSON.parse(response.body)

    expect(parsed_response.has_key?('workspaces')).to eq true
    expect(parsed_response.has_key?('projects')).to eq true
    expect(parsed_response.has_key?('tasks')).to eq true
  end
end
