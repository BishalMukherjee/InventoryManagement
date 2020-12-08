require 'rails_helper'

RSpec.describe Category, type: :model do
  context "validation tests" do
    let(:category) { build(:category) }
    
    it "should have a name" do
      category.name = nil
      expect(category.save).to eq(false)
    end

    it "should have unique name" do
      category.name = "keyboard"
      category.save
      dummy_category = Category.new(name: "keyboard")
      expect(dummy_category.save).to_not eq(true)
      expect(dummy_category.errors[:name]).to include("has already been taken")
    end
  end
end
