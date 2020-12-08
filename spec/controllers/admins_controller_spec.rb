require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  describe "admin access" do
    before(:each) do
      @first_admin = create(:first_admin)
      session[:user_id] = @first_admin.id
    end

    describe "GET#index" do
      it "populates an array of all admins" do
        admin = create(:admin)
        get :index
        expect(assigns(:admins)).to match_array [@first_admin, admin]
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET#new" do
      it "assigns a new admin to @admin" do
        get :new
        expect(assigns(:admin)).to be_a_new(Admin)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET#edit" do
      it "assigns a requested admin to @admin" do
        admin = create(:admin)
        get :edit, params: { id: admin }
        expect(assigns(:admin)).to eq admin
      end

      it "renders the edit template" do
        admin = create(:admin)
        get :edit, params: { id: admin }
        expect(response).to render_template :edit
      end
    end

    describe "POST#create" do
      context "with valid attributes" do
        it "saves the new admin in the database" do
          expect{ post :create, params: { admin: attributes_for(:admin)}}.to change(Admin, :count).by(1)
        end

        it "redirects to admin index page" do
          post :create, params: { admin: attributes_for(:admin) }
          expect(response).to redirect_to admins_path
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new admin into the database" do
          expect{ post :create, params: { admin: attributes_for(:invalid_admin)} }.to_not change(Admin, :count)
        end

        it "redirects to home page" do
          post :create, params: { admin: attributes_for(:invalid_admin)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH# update" do
      before(:each) do
        @admin = create(:admin, name: "Bishal Mukherjee")
      end

      context "with valid attributes" do
        it "located the requested admin" do
          patch :update, params: { id: @admin, admin: attributes_for(:admin) }
          expect(assigns(:admin)).to eq @admin  
        end

        it "changes the requested admins attribute" do
          patch :update, params: { id: @admin, admin: attributes_for(:admin, name: "Abhishek") }
          @admin.reload
          expect(@admin.name).to eq("Abhishek")
        end

        it "redirects to admin index page" do
          patch :update, params: { id: @admin, admin: attributes_for(:admin) }
          expect(response).to redirect_to admins_path
        end
      end

      context "with invalid attributes" do
        it "does not change the admins attributes" do
          patch :update, params: { id: @admin, admin: attributes_for(:admin, name: nil) }
          @admin.reload
          expect(@admin.name).to eq("Bishal Mukherjee")
        end

        it "redirects to home page" do
          patch :update, params: { id: @admin, admin: attributes_for(:invalid_admin)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE# destroy" do
      before(:each) do
        @admin = create(:admin)
      end

      it "deletes the admin" do
        expect{ delete :destroy, params: { id: @admin}}.to change(Admin, :count).by(-1)
      end

      it "redirects to the index page" do
        delete :destroy, params: { id: @admin}
        expect(response).to redirect_to admins_path
      end
    end
  end
end
