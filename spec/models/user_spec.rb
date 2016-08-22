require 'rails_helper'

describe User, type: :model do
  it { should define_enum_for(:role).with([:user, :admin]) }
  it { should have_many(:tasks).dependent(:destroy) }
  describe 'User #to_s' do
    let(:user) { FactoryGirl.build(:user, email: 'user@email.com') }
    it "returns user's email" do
      expect(user.to_s).to eq('user@email.com')
    end
  end

  describe 'User #original_tasks' do
    let(:user) { FactoryGirl.create(:user) }
    let(:user_tasks) { FactoryGirl.create_list(:task, 3, user: user) }

    it "returns user's tasks" do
      expect(user.original_tasks.map(&:user)).to all( eq(user))
    end
  end

  describe 'User #tasks' do
    let(:user) { FactoryGirl.create(:user) }
    let(:user_tasks) { FactoryGirl.create_list(:task, 3, user: user) }
    let(:admin) { FactoryGirl.create(:admin) }
    let(:user_tasks) { FactoryGirl.create_list(:task, 3, user: user) }

    context "when user is admin" do
      it "returns all tasks in system" do
        expect(admin.tasks).to eq(Task.all)
      end
    end

    context "when user is just a user" do
      it "returns only user's tasks" do
        expect(user.tasks.map(&:user)).to all( eq(user))
      end
    end
  end
end