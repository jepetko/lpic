require 'rails_helper'

describe Question, :type => :model do
  before(:each) do
    @q = FactoryGirl.create(:question)
  end

  it 'responds to text' do
    @q.should respond_to(:text)
  end

  context 'text is not nil' do
    it 'is valid' do
      @q.should be_valid
    end
  end

  context 'is invalid' do
    it 'when the text is nil' do
      invalid_q = Question.new(:text => nil)
      invalid_q.should_not be_valid
    end
  end
end
