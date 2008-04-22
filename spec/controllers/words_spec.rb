require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Words, "index action" do
  before(:each) do
    dispatch_to(Words, :index)
  end
end