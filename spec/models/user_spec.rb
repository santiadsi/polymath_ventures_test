require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association validations' do
    context 'With user' do
      it { should have_many(:tasks) }
    end
  end

  describe 'Validations' do
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'Incorrect password' do
    it 'Not create a user because his password is incorrect' do
      user = build(:user, password: 'nomatch', password_confirmation: '1321654')
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
