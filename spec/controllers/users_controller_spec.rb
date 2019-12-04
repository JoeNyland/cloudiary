require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:user) { create :user }
  let (:other_user) { create :user }

  describe 'GET #new' do
    it 'should be successful' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    context 'not logged in' do
      it 'should redirect to login' do
        get :edit, params: { id: user }
        expect(response).to redirect_to(login_path)
      end
    end

    context 'logged in as the wrong user' do
      before do
        log_in_as other_user
      end

      it 'should redirect to root' do
        get :edit, params: { id: user }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'not logged in' do
      it 'should redirect to login' do
        patch :update, params: { id: user, user: { name: user.name, email: user.email } }
        expect(response).to redirect_to(login_path)
      end
    end

    context 'logged in as the wrong user' do
      before do
        log_in_as other_user
      end

      it 'should redirect to root' do
        patch :update, params: { id: user, user: { name: user.name, email: user.email } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
