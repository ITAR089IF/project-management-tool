require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {create :user, first_name: 'John', last_name: 'Doe'}
  it 'returns full name' do
    it {expect(user.full_name).to eq 'John Dou'}
  end
end
