require 'rails_helper'

describe User, type: :model do
  it { should define_enum_for(:role).with([:user, :admin]) }
  describe 'User #to_s' do
    let(:user) { FactoryGirl.build(:user, email: 'user@email.com') }
    it "returns user's email" do
      expect(user.to_s).to eq('user@email.com')
    end
  end
end