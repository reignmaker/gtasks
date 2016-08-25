require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe '#render_task_attachment' do
    context 'when attachment has file' do
      let(:attachment) { FactoryGirl.create(:file) }
      it 'returns link to to file' do
        expect(helper.render_task_attachment(attachment)).to match(/href/)
      end
    end

    context 'when attachment has image' do
      let(:attachment) { FactoryGirl.create(:image) }
      it 'returns image tag' do
        expect(helper.render_task_attachment(attachment)).to match(/img/)
      end
    end

    context "when attachment has no file" do
      let(:attachment) { FactoryGirl.create(:file, file: '') }
      it "returns false" do
        expect(helper.render_task_attachment(attachment)).to be_falsy
      end
    end
  end

  describe '#task_state_active' do
    let(:task) { FactoryGirl.create(:task, state: 1) } # started
    it "returns `active`" do
      expect(helper.task_state_active(task, :started)).to eq('active')
    end

    it "returns nothing" do
      expect(helper.task_state_active(task, :finished)).to be_nil
    end
  end
end