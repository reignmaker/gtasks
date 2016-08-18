describe Web::WelcomeController, type: :controller do
  let(:tasks) { FactoryGirl.create_list(:task, 3) }

  it "renders index template" do
    get :index
    expect(response).to render_template(:index)
  end

  it "assignes tasks to template" do
    get :index
    expect(assigns[:tasks]).to match_array(tasks)
  end
end