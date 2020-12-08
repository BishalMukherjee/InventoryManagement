require 'rails_helper'

RSpec.describe Storage, type: :model do
  context "validation tests" do
    let(:category) { create(:category) }
    let(:storage) { build(:storage, category: category) }

    it "should belong to a category" do
      storage.category_id = nil
      expect(storage.save).to eq(false)
    end

    it "should belong to unique category" do
      storage.save
      dummy_storage = Storage.new(category_id: category.id, procurement_time: storage.procurement_time)
      expect(dummy_storage.save).to eq(false)
      expect(dummy_storage.errors[:category_id]).to include("storage details already available.")
    end

    it "should have a purchase date" do
      storage.procurement_time = nil
      expect(storage.save).to eq(false)
    end

    it "should have a total attribute" do
      storage.total = nil
      expect(storage.save).to eq(false)
    end

    it "should have a buffer attribute" do
      storage.buffer = nil
      expect(storage.save).to eq(false)
    end

    it "shouldn't have a negative value of total" do
      storage.total = -2
      expect(storage.save).to eq(false)
    end

    it "shouldn't have a negative value of buffer" do
      storage.buffer = -1
      expect(storage.save).to eq(false)
    end
  end
end
