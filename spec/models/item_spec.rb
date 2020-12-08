require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validation tests" do
    let(:category) { create(:category) }
    let!(:storage) { create(:storage, category: category) }
    let(:brand) { create(:brand, category: category) }
    let(:item) { build(:item, brand: brand) }
    let(:employee) { build(:employee) }

    it "should have a name" do
      item.name = nil
      expect(item.save).to eq(false)
    end

    it "should have unique name" do
      item.name = "HP-765 Keyboard"
      item.save
      dummy_item = Item.new(name: "HP-765 Keyboard", brand_id: brand.id)
      expect(dummy_item.save).to_not eq(true)
      expect(dummy_item.errors[:name]).to include("has already been taken")
    end

    it "should be assigned to valid employee" do
      employee.id = 10
      employee.save
      item.employee_id = 15
      expect(item.save).to eq(false)
    end

    it "should be assigned to an existing employee" do
      employee.id = 12
      employee.save
      item.employee_id = 12
      expect(item.save).to eq(true)
    end

    it "should have storage details" do
      item.brand.category.storage.total = 0
      expect(item.save).to eq(false)
    end

    it "should be available in storage" do
      item.brand.category.storage.total = 2
      FactoryBot.create_list(:item, 2, brand: brand)
      expect(item.save).to eq(false)
    end
  end
end
