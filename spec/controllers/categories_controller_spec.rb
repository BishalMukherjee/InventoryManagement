require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "admin access" do
    before(:each) do
      @admin = create(:first_admin)
      session[:user_id] = @admin.id
    end

    describe "GET#index" do
      it "populates an array of all categorys" do
        category = create_list(:category, 3)
        get :index
        expect(assigns(:categories)).to match_array (category)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET#new" do
      it "assigns a new contact to @contact" do
        get :new
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST#create" do
      context "with valid attributes" do
        it "saves the new category in the database" do
          expect{ post :create, params: { category: attributes_for(:category)}}.to change(Category, :count).by(1)
        end

        it "redirects to category index page" do
          post :create, params: { category: attributes_for(:category) }
          expect(response).to redirect_to categories_path
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new category into the database" do
          expect{ post :create, params: { category: attributes_for(:invalid_category)} }.to_not change(Category, :count)
        end

        it "redirects to home page" do
          post :create, params: { category: attributes_for(:invalid_category)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE# destroy" do
      before(:each) do
        @category = create(:category)
      end

      it "deletes the category" do
        expect{ delete :destroy, params: { id: @category}}.to change(Category, :count).by(-1)
      end

      it "redirects to the index page" do
        delete :destroy, params: { id: @category}
        expect(response).to redirect_to categories_path
      end
    end
  end
end