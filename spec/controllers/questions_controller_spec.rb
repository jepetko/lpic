require 'rails_helper'

describe QuestionsController do
  render_views

  before(:each) do
    @q = FactoryGirl.create(:question)
  end

  context 'if user is not logged-in' do
    it 'he is redirected to log-in form' do
      get :show, :id => @q.id
      response.should redirect_to('/users/sign_in')
    end
  end

  context 'if user is logged-in' do

    before(:each) do
      @u = FactoryGirl.create(:user)
      @u.confirm!
      sign_in :user, @u
    end

    describe 'routing' do
      it 'routes to #new' do
        {
          :get => 'questions/new'
        }.should route_to(:controller => 'questions', :action => 'new')
      end

    end
  end
end