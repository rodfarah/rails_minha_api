require 'rails_helper'

RSpec.describe User, type: :model do
  # Testing validations using Shoulda
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  # Testing associations
  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
  end

  # Testing enums
  describe 'enums' do
    it { should define_enum_for(:gender).with_values(male: 0, female: 1, other: 2) }
    it { should define_enum_for(:role).with_values(admin: 0, user: 1) }
  end

  # Testing custom methods
  describe '#is_admin?' do
    context 'when user is admin' do
      let(:admin_user) { create(:user, :admin) }
      it 'return true' do
        expect(admin_user.is_admin?).to be true
      end
    end
    context 'when user is not admin' do
      let(:regular_user) { create(:user) }
      it 'return false' do
        expect(regular_user.is_admin?).to be false
      end
    end
  end

  # Testing authentication
  describe 'authentication' do
    let(:user) { create(:user, password: 'password123') }
    it 'authenticates with correct password' do
      expect(user.authenticate('password123')).to eq(user)
    end
    it 'does not authenticate with incorrect password' do
      expect(user.authenticate('wrongpassword')).to be false
    end
  end
end
