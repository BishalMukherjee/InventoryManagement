require 'rails_helper'

RSpec.describe IssuesController, type: :controller do
  describe "admin access" do
    before(:each) do
      @admin = create(:first_admin)
      session[:user_id] = @admin.id
      @category = create(:category)
      @storage = create(:storage, category_id: @category.id)
      @brand = create(:brand, category_id: @category.id)
      @item = create(:item, brand_id: @brand.id)
    end

    describe "GET#index" do
      it "populates an array of all issues" do
        first_item = create(:item, brand_id: @brand.id)
        first_issue = create(:issue, item_id: first_item.id)
        second_item = create(:item, brand_id: @brand.id)
        second_issue = create(:issue, item_id: second_item.id)
        issues = [first_issue, second_issue]
        get :index
        expect(assigns(:issues)).to match_array (issues)
      end

      it "renders the index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET#new" do
      it "assigns a new issue to @issue" do
        get :new
        expect(assigns(:issue)).to be_a_new(Issue)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET#edit" do
      it "assigns a requested issue to @issue" do
        issue = create(:issue, item_id: @item.id)
        get :edit, params: { id: issue }
        expect(assigns(:issue)).to eq issue
      end

      it "renders the edit template" do
        issue = create(:issue, item_id: @item.id)
        get :edit, params: { id: issue }
        expect(response).to render_template :edit
      end
    end

    describe "POST#create" do
      context "with valid attributes" do
        it "saves the new issue in the database" do
          expect{ post :create, params: { issue: attributes_for(:issue, item_id: @item)}}.to change(Issue, :count).by(1)
        end

        it "redirects to issue index page" do
          post :create, params: { issue: attributes_for(:issue, item_id: @item) }
          expect(response).to redirect_to issues_path
        end
      end

      context "with invalid attributes" do
        it "doesn't save the new issue into the database" do
          expect{ post :create, params: { issue: attributes_for(:invalid_issue)} }.to_not change(Issue, :count)
        end

        it "redirects to home page" do
          post :create, params: { issue: attributes_for(:invalid_issue)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH# update" do
      before(:each) do
        @issue = create(:issue, details: "no problem", item_id: @item.id)
      end

      context "with valid attributes" do
        it "located the requested issue" do
          patch :update, params: { id: @issue, issue: attributes_for(:issue) }
          expect(assigns(:issue)).to eq @issue  
        end

        it "changes the requested issues attribute" do
          patch :update, params: { id: @issue, issue: attributes_for(:issue, details: "lots of problem") }
          @issue.reload
          expect(@issue.details).to eq("lots of problem")
        end

        it "redirects to issue index page" do
          patch :update, params: { id: @issue, issue: attributes_for(:issue) }
          expect(response).to redirect_to issues_path
        end
      end

      context "with invalid attributes" do
        it "does not change the issues attributes" do
          patch :update, params: { id: @issue, issue: attributes_for(:invalid_issue) }
          @issue.reload
          expect(@issue.details).to eq("no problem")
        end

        it "redirects to home page" do
          patch :update, params: { id: @issue, issue: attributes_for(:invalid_issue)}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE# destroy" do
      before(:each) do
        @issue = create(:issue, item_id: @item.id)
      end

      it "deletes the issue" do
        expect{ delete :destroy, params: { id: @issue}}.to change(Issue, :count).by(-1)
      end

      it "redirects to the index page" do
        delete :destroy, params: { id: @issue}
        expect(response).to redirect_to issues_path
      end
    end
  end
end
