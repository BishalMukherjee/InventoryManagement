require 'rails_helper'

RSpec.describe Issue, type: :model do
  context "validation tests" do
    let(:category) { create(:category) }
    let(:brand) { create(:brand, category: category) }
    let(:item) { create(:item, brand: brand) }
    let!(:storage) { create(:storage, category: category) }
    let(:issue) { build(:issue, item: item) }

    it "should have issue details" do
      issue.details = nil
      expect(issue.save).to eq(false)
    end

    it "should belong to a item" do
      issue.item_id = nil
      expect(issue.save).to eq(false)
    end
  end
end
