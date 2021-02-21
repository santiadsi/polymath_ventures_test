require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Association validations' do
    context 'With user' do
      it { should belong_to(:user) }
    end
  end

  describe 'Validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user) }
    it { should allow_value(true, false).for(:complete) }
  end

  describe '.search_query' do
    it 'Validate scope filterrific search_query' do
      task = create(:task)
      res = Task.search_query(task.description)
      expect(res.first.present?).to be_truthy
      expect(res.first.description).to eq task.description
    end
  end
end
