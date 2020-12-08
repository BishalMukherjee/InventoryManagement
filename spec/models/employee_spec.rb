require 'rails_helper'

RSpec.describe Employee, type: :model do
  context "validation tests" do
    let(:employee) { build(:employee) }
    
    it "should have a name" do
      employee.name = nil
      expect(employee.save).to_not eq(true)
    end

    it "should have a valid email address" do 
      employee.email = "email@example"
      expect(employee.save).to_not eq(true)
    end

    it "should have unique email address" do
      employee.email = "bishalmukherjee7@gmail.com"
      employee.save
      dummy_employee = Employee.new(email: "bishalmukherjee7@gmail.com")
      expect(dummy_employee.save).to_not eq(true)
      expect(dummy_employee.errors[:email]).to include("has already been taken")
    end
  end
end
