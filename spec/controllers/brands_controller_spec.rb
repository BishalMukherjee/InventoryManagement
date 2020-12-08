require 'rails_helper'

RSpec.describe BrandsController, type: :controller do
  describe "admin access" do
    before(:each) do
      @admin = create(:first_admin)
      session[:user_id] = @admin.id
    end

    describe "GET#index" do
      it "populates an array of all brands" do
        brand = create_list(:brand, 3)
        get :index
        expect(assigns(:brands)).to match_array (brand)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET#new" do
      it "assigns a new contact to @contact" do
        get :new
        expect(assigns(:brand)).to be_a_new(Brand)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST#create" do
      before(:each) do
        @category = create(:category)
      end
      
      context "with valid attributes" do
        it "saves the new brand in the database" do
          expect{ post :create, params: { brand: attributes_for(:brand, category_id: @category )}}.to change(Brand, :count).by(1)
        end

        it "redirects to brand index page" do
          category = create(:category)
          post :create, params: { brand: attributes_for(:brand, category_id: @category) }
          expect(response).to redirect_to brands_path
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new brand into the database" do
          expect{ post :create, params: { brand: attributes_for(:invalid_brand)} }.to_not change(Brand, :count)
        end

        it "redirects to home page" do
          post :create, params: { brand: attributes_for(:invalid_brand)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE# destroy" do
      before(:each) do
        @brand = create(:brand)
      end

      it "deletes the brand" do
        expect{ delete :destroy, params: { id: @brand}}.to change(Brand, :count).by(-1)
      end

      it "redirects to the index page" do
        delete :destroy, params: { id: @brand}
        expect(response).to redirect_to brands_path
      end
    end
  end
end