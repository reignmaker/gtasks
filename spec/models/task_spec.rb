require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_one(:attachment).dependent(:destroy) }
  it { should accept_nested_attributes_for(:attachment).allow_destroy(true) }

  describe 'Task #reject_attachment' do
    let(:task) { FactoryGirl.build(:task) }

    context "when attachment has no file" do
      it "rejects attachment" do
        empty_attachment = FactoryGirl.attributes_for(:attachment, file: '')
        expect(task.send(:reject_attachment, empty_attachment)).to be_truthy
      end
    end

    context "when attachment has file" do
      it "accepts attachment" do
        attachment = FactoryGirl.attributes_for(:attachment)
        expect(task.send(:reject_attachment, attachment)).to be_falsy
      end
    end
  end

  describe 'Task .states' do
    let(:states) { [:new, :started, :finished] }

    it "returns arrays of states" do
      expect(Task.states).to eq(states)
    end
  end

  describe 'Task .events' do
    let(:events) { Task.state_machines[:state].events.map(&:name) }

    it "returns arrays of state_machines events" do
      expect(Task.events).to eq(events)
    end
  end
end
