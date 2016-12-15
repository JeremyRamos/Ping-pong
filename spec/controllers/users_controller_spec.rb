require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET new" do
    it 'instantiates a new user' do
      get :new
      expect(assigns(:user)).to be_a_new User
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      let(:params) { { name: 'Jeremy' } }
      subject { post :create, user: params }

      it 'creates a new user' do
        expect { subject }.to change(User, :count).by 1
      end

      it 'redirect_to the index page' do
        subject
        expect(response).to redirect_to users_path
      end
    end

    context 'with invalid params' do
      let(:params) { { name: '' } }
      subject { post :create, user: params }

      it 'does not create a new user' do
        expect { subject }.to_not change(User, :count)
      end

      it 'renders the new template' do
        subject
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET index' do
    let(:users) { create(:user) }

    it 'list all the users' do
      get :index
      expect(assigns(:users)).to eq [users]
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end
end
