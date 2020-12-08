require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe "admin access" do
    before(:each) do
      @first_admin = create(:first_admin)
      session[:user_id] = @first_admin.id
      @category = create(:category)
      @storage = create(:storage, category_id: @category.id)
      @brand = create(:brand, category_id: @category.id)
    end

    describe "GET#index" do
      it "populates an array of all items" do
        items = create_list(:item, 3, brand_id: @brand.id)
        get :index
        expect(assigns(:items)).to match_array (items)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET#new" do
      it "assigns a new item to @item" do
        get :new
        expect(assigns(:item)).to be_a_new(Item)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET#show" do
      it "shows the requested item" do
        item = create(:item, brand_id: @brand.id)
        get :show, params: { id: item }
        expect(assigns(:item)).to eq(item)
      end

      it "renders the show template" do
        item = create(:item, brand_id: @brand.id)
        get :show, params: { id: item }
        expect(response).to render_template :show
      end
    end

    describe "GET#edit" do
      it "assigns a requested item to @item" do
        item = create(:item, brand_id: @brand.id)
        get :edit, params: { id: item }
        expect(assigns(:item)).to eq item
      end

      it "renders the edit template" do
        item = create(:item, brand_id: @brand.id)
        get :edit, params: { id: item }
        expect(response).to render_template :edit
      end
    end

    describe "POST#create" do
      context "with valid attributes" do
        it "saves the new item in the database" do
          expect{ post :create, params: { item: attributes_for(:item, brand_id: @brand.id)}}.to change(Item, :count).by(1)
        end

        it "redirects to item index page" do
          post :create, params: { item: attributes_for(:item, brand_id: @brand.id) }
          expect(response).to redirect_to items_path
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new item into the database" do
          expect{ post :create, params: { item: attributes_for(:invalid_item, brand_id: @brand.id)} }.to_not change(Item, :count)
        end

        it "redirects to home page" do
          post :create, params: { item: attributes_for(:invalid_item, brand_id: @brand.id)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH# update" do
      before(:each) do
        @item = create(:item, name: "Keyboard1750", brand_id: @brand.id)
      end

      context "with valid attributes" do
        it "located the requested item" do
          patch :update, params: { id: @item, item: attributes_for(:item) }
          expect(assigns(:item)).to eq @item  
        end

        it "changes the requested items attribute" do
          patch :update, params: { id: @item, item: attributes_for(:item, name: "Monitor6453") }
          @item.reload
          expect(@item.name).to eq("Monitor6453")
        end

        it "redirects to item index page" do
          patch :update, params: { id: @item, item: attributes_for(:item) }
          expect(response).to redirect_to items_path
        end
      end

      context "with invalid attributes" do
        it "does not change the items attributes" do
          patch :update, params: { id: @item, item: attributes_for(:item, name: nil) }
          @item.reload
          expect(@item.name).to eq("Keyboard1750")
        end

        it "redirects to home page" do
          patch :update, params: { id: @item, item: attributes_for(:invalid_item)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE# destroy" do
      before(:each) do
        @item = create(:unassigned_item, brand_id: @brand.id)
      end

      it "deletes the item" do
        expect{ delete :destroy, params: { id: @item }}.to change(Item, :count).by(-1)
      end

      it "redirects to the index page" do
        delete :destroy, params: { id: @item}
        expect(response).to redirect_to items_path
      end
    end
  end
end
