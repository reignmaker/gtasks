describe Web::Users::WelcomeController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  describe "GET index" do
    context "when not logged in" do
      before do
        sign_out
      end
      it "redirects to sign_in_path" do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end

    shared_examples 'template rendering' do
      it "renders index template" do
        sign_in_as(user)
        get :index
        expect(response).to render_template(:index)
      end
    end


    context "with user role" do
      it_behaves_like 'template rendering'

      it "assignes only users tasks to template" do
        user_tasks = FactoryGirl.create_list(:task, 3, user: user)
        sign_in_as(user)
        get :index
        expect(assigns[:tasks]).to match_array(user_tasks)
      end
    end

    context "with admin role" do
      it "assignes all tasks to template" do
        user_tasks = FactoryGirl.create_list(:task, 3, user: user)
        admin_tasks = FactoryGirl.create_list(:task, 3, user: admin)
        sign_in_as(admin)
        get :index
        expect(assigns[:tasks]).to match_array([user_tasks, admin_tasks].flatten)
      end
    end

  end
end