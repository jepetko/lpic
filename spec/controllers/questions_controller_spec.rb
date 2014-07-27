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

      @q = FactoryGirl.create(:question)
    end

    describe 'routing' do
      it 'routes to #new' do
        {
          :get => '/questions/new'
        }.should route_to(:controller => 'questions', :action => 'new')
      end

      it 'routes to #create' do
        q = Question.new :text => 'this is a question'
        {
          :post => '/questions'
        }.should route_to(:controller => 'questions', :action => 'create')
      end

      it 'routes to #show' do
        {
          :get => "/questions/#{@q.id}"
        }.should route_to(:controller => 'questions', :action => 'show', :id => "#{@q.id}")
      end

      it 'routes to #index' do
        {
          :get => '/questions'
        }.should route_to(:controller => 'questions', :action => 'index')
      end

      it 'routes to #update' do
        {
          :put => "/questions/#{@q.id}"
        }.should route_to(:controller => 'questions', :action => 'update', :id => "#{@q.id}")
      end

      it 'routes to #destroy' do
        {
          :delete => "/questions/#{@q.id}"
        }.should route_to(:controller => 'questions', :action => 'destroy', :id => "#{@q.id}")
      end
    end

    describe 'get :new' do
      it 'is successful' do
        get :new
        response.should be_success
        response.body.should have_xpath("//textarea[@id='question_text']")
      end
    end
  end
end