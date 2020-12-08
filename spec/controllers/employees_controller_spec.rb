require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  describe "admin access" do
    before(:each) do
      @first_admin = create(:first_admin)
      session[:user_id] = @first_admin.id
    end

    describe "GET#index" do
      it "populates an array of all employees" do
        employees = create_list(:employee, 3)
        get :index
        expect(assigns(:employees)).to match_array (employees)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET#new" do
      it "assigns a new employee to @employee" do
        get :new
        expect(assigns(:employee)).to be_a_new(Employee)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET#show" do
      it "shows the requested employee" do
        employee = create(:employee)
        get :show, params: { id: employee }
        expect(assigns(:employee)).to eq(employee)
      end

      it "renders the show template" do
        employee = create(:employee)
        get :show, params: { id: employee }
        expect(response).to render_template :show
      end
    end

    describe "GET#edit" do
      it "assigns a requested employee to @employee" do
        employee = create(:employee)
        get :edit, params: { id: employee }
        expect(assigns(:employee)).to eq employee
      end

      it "renders the edit template" do
        employee = create(:employee)
        get :edit, params: { id: employee }
        expect(response).to render_template :edit
      end
    end

    describe "POST#create" do
      context "with valid attributes" do
        it "saves the new employee in the database" do
          expect{ post :create, params: { employee: attributes_for(:employee)}}.to change(Employee, :count).by(1)
        end

        it "redirects to employee index page" do
          post :create, params: { employee: attributes_for(:employee) }
          expect(response).to redirect_to employees_path
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new employee into the database" do
          expect{ post :create, params: { employee: attributes_for(:invalid_employee)} }.to_not change(Employee, :count)
        end

        it "redirects to home page" do
          post :create, params: { employee: attributes_for(:invalid_employee)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH# update" do
      before(:each) do
        @employee = create(:employee, name: "Bishal Mukherjee")
      end

      context "with valid attributes" do
        it "located the requested employee" do
          patch :update, params: { id: @employee, employee: attributes_for(:employee) }
          expect(assigns(:employee)).to eq @employee  
        end

        it "changes the requested employees attribute" do
          patch :update, params: { id: @employee, employee: attributes_for(:employee, name: "Abhishek") }
          @employee.reload
          expect(@employee.name).to eq("Abhishek")
        end

        it "redirects to employee index page" do
          patch :update, params: { id: @employee, employee: attributes_for(:employee) }
          expect(response).to redirect_to employees_path
        end
      end

      context "with invalid attributes" do
        it "does not change the employees attributes" do
          patch :update, params: { id: @employee, employee: attributes_for(:employee, name: nil) }
          @employee.reload
          expect(@employee.name).to eq("Bishal Mukherjee")
        end

        it "redirects to home page" do
          patch :update, params: { id: @employee, employee: attributes_for(:invalid_employee)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE# destroy" do
      before(:each) do
        @employee = create(:inactive_employee)
      end

      it "deletes the employee" do
        expect{ delete :destroy, params: { id: @employee }}.to change(Employee, :count).by(-1)
      end

      it "redirects to the index page" do
        delete :destroy, params: { id: @employee}
        expect(response).to redirect_to employees_path
      end
    end
  end
end
