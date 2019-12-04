require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let (:entry) { create :entry }
  let (:user) { entry.user }
  let (:other_user) { create :user }

  describe 'GET #new' do
    let (:params) { { user_id: user } }

    before do
      log_in_as user
    end

    it 'should be successful' do
      get :new, params: params
      expect(response).to be_successful
    end

    context 'not logged in' do
      before do
        log_out
      end

      it 'should redirect to the login page' do
        get :new, params: params
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #create' do
    let (:params) { { user_id: user, entry: {title: 'test', body: 'test'*5} } }

    before do
      log_in_as user
    end

    context 'not logged in' do
      before do
        log_out
      end

      it 'should redirect to the login page' do
        post :create, params: params
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #show' do
    let (:params) { { id: entry, user_id: user } }

    context 'not logged in' do
      before do
        log_out
      end

      it 'should redirect to the login page' do
        get :show, params: params
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #edit' do
    let (:params) { { id: entry, user_id: user } }

    before do
      log_in_as user
    end

    it 'should be successful' do
      get :edit, params: params
      expect(response).to be_successful
    end

    context 'not logged in' do
      before do
        log_out
      end

      it 'should redirect to the login page' do
        get :edit, params: params
        expect(response).to redirect_to(login_path)
      end
    end

    context 'logged in as the wrong user' do
      before do
        log_in_as other_user
      end

      it 'should redirect to root' do
        get :edit, params: params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    let (:params) { { id: entry, user_id: user, entry: { body: 'test'*5 } } }

    before do
      log_in_as user
    end

    it 'should be successful' do
      patch :update, params: params
      expect(response).to redirect_to(user_entry_path(user, entry))
    end

    context 'not logged in' do
      before do
        log_out
      end

      it 'should redirect to the login page' do
        patch :update, params: params
        expect(response).to redirect_to(login_path)
      end
    end

    context 'logged in as the wrong user' do
      before do
        log_in_as other_user
      end

      it 'should redirect to root' do
        patch :update, params: params
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
