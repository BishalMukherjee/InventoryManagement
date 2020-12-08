require 'rails_helper'

RSpec.describe StoragesController, type: :controller do
  describe "admin access" do
    before(:each) do
      @admin = create(:first_admin)
      session[:user_id] = @admin.id
      @category = create(:category)
    end

    describe "GET#index" do
      it "populates an array of all storages" do
        first_category = create(:category)
        first_storage = create(:storage, category_id: first_category.id)
        second_category = create(:category)
        second_storage = create(:storage, category_id: second_category.id)
        storages = [first_storage, second_storage]
        get :index
        expect(assigns(:storages)).to match_array (storages)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET#new" do
      it "assigns a new contact to @contact" do
        get :new
        expect(assigns(:storage)).to be_a_new(Storage)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET#edit" do
      it "assigns a requested storage to @storage" do
        storage = create(:storage, category_id: @category.id)
        get :edit, params: { id: storage }
        expect(assigns(:storage)).to eq storage
      end

      it "renders the edit template" do
        storage = create(:storage, category_id: @category.id)
        get :edit, params: { id: storage }
        expect(response).to render_template :edit
      end
    end

    describe "POST#create" do
      context "with valid attributes" do
        it "saves the new storage in the database" do
          expect{ post :create, params: { storage: attributes_for(:storage, category_id: @category )}}.to change(Storage, :count).by(1)
        end

        it "redirects to storage index page" do
          category = create(:category)
          post :create, params: { storage: attributes_for(:storage, category_id: @category) }
          expect(response).to redirect_to storages_path
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new storage into the database" do
          expect{ post :create, params: { storage: attributes_for(:invalid_storage)} }.to_not change(Storage, :count)
        end

        it "redirects to home page" do
          post :create, params: { storage: attributes_for(:invalid_storage)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH# update" do
      before(:each) do
        @storage = create(:storage, total: 10, category_id: @category.id)
      end

      context "with valid attributes" do
        it "located the requested storage" do
          patch :update, params: { id: @storage, storage: attributes_for(:storage) }
          expect(assigns(:storage)).to eq @storage  
        end

        it "changes the requested storages attribute" do
          patch :update, params: { id: @storage, storage: attributes_for(:storage, total: 8) }
          @storage.reload
          expect(@storage.total).to eq(8)
        end

        it "redirects to storage index page" do
          patch :update, params: { id: @storage, storage: attributes_for(:storage) }
          expect(response).to redirect_to storages_path
        end
      end

      context "with invalid attributes" do
        it "does not change the storages attributes" do
          patch :update, params: { id: @storage, storage: attributes_for(:invalid_storage) }
          @storage.reload
          expect(@storage.total).to eq(10)
        end

        it "redirects to home page" do
          patch :update, params: { id: @storage, storage: attributes_for(:invalid_storage)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE# destroy" do
      before(:each) do
        @storage = create(:storage, category_id: @category.id)
      end

      it "deletes the storage" do
        expect{ delete :destroy, params: { id: @storage}}.to change(Storage, :count).by(-1)
      end

      it "redirects to the index page" do
        delete :destroy, params: { id: @storage}
        expect(response).to redirect_to storages_path
      end
    end
  end
end