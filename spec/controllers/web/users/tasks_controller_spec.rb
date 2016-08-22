require 'rails_helper'

describe Web::Users::TasksController, type: :controller do
  render_views
  let(:user) { FactoryGirl.create(:user) }
  let(:task) { FactoryGirl.create(:task, user: user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:other_user) { FactoryGirl.create(:user) }
  it { should use_before_action(:load_task) }

  context 'when not authenticated' do

    describe 'GET new' do
      before { get :new }
      it { should redirect_to(sign_in_path) }
    end

    describe 'GET show' do
      before { get :show, id:  task}
      it { should redirect_to(sign_in_path) }
    end

    describe 'GET edit' do
      before { get :edit, id: task }
      it { should redirect_to(sign_in_path) }
    end

    describe 'PUT update' do
      before { put :update, id: task }
      it { should redirect_to(sign_in_path) }
    end

    describe 'PATCH change_state' do
      before { patch :change_state, id: task, state: :start }
      it { should redirect_to(sign_in_path) }
    end

    describe 'DELETE destroy' do
      before { delete :destroy, id: task }
      it { should redirect_to(sign_in_path) }
    end
  end

  shared_examples 'task owner' do
    describe 'GET new' do
      before { get :new }

      it { should render_template(:new) }

      it 'assigns new @task to template' do
        expect(assigns[:task]).to be_a_new(Task)
      end
    end

    describe 'GET show' do
      before { get :show, id: task }

      it { should render_template(:show) }

      it 'assigns @task to template' do
        expect(assigns[:task]).to eq(task)
      end
    end

    describe 'GET edit' do
      before { get :edit, id: task }

      it { should render_template(:edit) }

      it 'assigns @task to template' do
        expect(assigns[:task]).to eq(task)
      end
    end

    describe 'PUT update' do
      let(:task_data) { FactoryGirl.attributes_for(:task, name: 'New task') }

      it 'updates task record' do
        put :update, id: task, task: task_data
        task.reload
        expect(task.name).to eq('New task')
      end

      it 'redirects to task page' do
        put :update, id: task, task: FactoryGirl.attributes_for(:task)
        expect(response).to redirect_to(users_task_path(task))
      end
    end

    describe 'POST create' do
      context 'with valid data' do
        it "redirects to newly created task page" do
          post :create, task: FactoryGirl.attributes_for(:task)
          should redirect_to(users_task_path(assigns[:task]))
        end

        it 'creates new task record' do
          expect {
            post :create, task: FactoryGirl.attributes_for(:task)
          }.to change(Task, :count).by(1)
        end

      end

    end

    describe 'PATCH change_state' do
      before { patch :change_state, id: task, state: :start }
      it { should respond_with(200) }

      it 'should update task\'s status' do
        task.reload
        expect(task).to be_started
      end
    end

    describe 'DELETE destroy' do
      before { delete :destroy, id: task }
      it { should redirect_to(users_root_path) }

      it 'deletes task' do
        expect(Task.exists?(task.id)).to be_falsy
      end
    end
  end

  context 'when authenticated with user role' do
    before do
      sign_in_as(user)
    end

    it_behaves_like 'task owner'
  end

  context 'when authenticated with admin role' do
    before do
      sign_out
      sign_in_as(admin)
    end

    it_behaves_like 'task owner'
  end

  context 'when user is not task owner' do
    before do
      sign_out
      sign_in_as(other_user)
    end

    describe 'GET show' do
      before { get :show, id:  task}
      it { should respond_with(404) }
    end

    describe 'GET edit' do
      before { get :edit, id: task }
      it { should respond_with(404) }
    end

    describe 'PUT update' do
      before { put :update, id: task }
      it { should respond_with(404) }
    end

    describe 'PATCH change_state' do
      before { patch :change_state, id: task, state: :start }
      it { should respond_with(404) }
    end

    describe 'DELETE destroy' do
      before { delete :destroy, id: task }
      it { should respond_with(404) }
    end
  end
end
