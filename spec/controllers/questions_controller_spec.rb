require 'rails_helper'

describe QuestionsController do
  render_views

  before(:each) do
    @q = FactoryGirl.create(:question)
  end

  describe 'if user is not logged-in' do
    it 'he is redirected to log-in form' do
      get :show, :id => @q.id
      response.should redirect_to('/users/sign_in')
    end
  end
end