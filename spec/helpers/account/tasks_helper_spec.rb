require 'rails_helper'

RSpec.describe Account::TasksHelper, type: :helper do
  describe "#task_style" do
    it "returns classes" do
      expect(helper.task_style(true, true)).to eq('title is-4 is-italic')
      expect(helper.task_style(false, true)).to eq("has-text-danger")
      expect(helper.task_style(false, false)).to eq('')
    end
  end
  
end
