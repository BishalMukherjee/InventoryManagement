require 'rails_helper'

RSpec.describe Admin, type: :model do
  context "validation tests" do
    let(:admin) { build(:admin) }
    
    it "should be valid with valid attributes" do
      expect(admin.save).to eq(true)
    end

    it "should have a name" do
      admin.name = nil
      expect(admin.save).to_not eq(true)
    end

    it "should have a valid email address" do 
      admin.email = "email@example"
      expect(admin.save).to_not eq(true)
    end

    it "should have unique email address" do
      admin.email = "bishalmukherjee7@gmail.com"
      admin.save
      dummy_admin = Admin.new(email: "bishalmukherjee7@gmail.com")
      expect(dummy_admin.save).to_not eq(true)
      expect(dummy_admin.errors[:email]).to include("has already been taken")
    end
  end

  context "class method tests" do
    let(:admin) { build(:admin) }
    it "should return true if the person logging in, exists in admin table" do
      admin.email = "bishalmukherjee7@gmail.com"
      admin.save
      log_in = Admin.sign_in_from_omniauth("bishalmukherjee7@gmail.com")
      expect(admin == log_in).to eq(true)
    end
  end
end
