require 'rails_helper'

RSpec.describe Brand, type: :model do
  context "validation tests" do
    let(:category) { create(:category) }
    let(:brand) { build(:brand, category: category) }

    it "should have a name" do
      brand.name = nil
      expect(brand.save).to eq(false)
    end

    it "should belong to a category" do
      brand.category_id = nil
      expect(brand.save).to eq(false)
    end
  end
end
