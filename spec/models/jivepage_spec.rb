require File.dirname(__FILE__) + '/../spec_helper'

describe Jivepage do
  before(:each) do
    @jivepage = Jivepage.create
    # @pmark = mock_model(User, :summary => "pmark", :id => 2, :valid? => true)
    # @lavender = mock_model(Product, :summary => "Lavender Oil (3329)")
  end

  it "should make a nice heading for an anonymous user" do
    correct = "Less than a minute ago Anonymous wrote about Lavender Oil (3329). Nobody is editing this page at the moment."
    # @jivepage.subject = @# lavender
    # @jivepage.heading.should == correct
  end
  
  it "should make a nice heading for a member" do
    # correct = "Less than a minute ago pmark wrote about Lavender Oil (3329). Nobody is editing this page at the moment."
    # @jivepage.user = @pmark
    # @jivepage.subject = @lavender
    # @jivepage.heading.should == correct
  end
  
  it "should make a nice heading for a member" do
    correct = "Right now pmark is writing about Lavender Oil (3329). Nobody else is editing at the moment."
    # @jivepage.user = @pmark
    # @jivepage.subject = @lavender
    # @jivepage.edit_sessions.create(:user => @pmark)
    # @jivepage.heading.should == correct
  end
  
  it "should make a nice heading for a member" do
    correct = "Right now pmark is editing this page. Nobody else is editing at the moment."
    # @jivepage.user = @pmark
    # @jivepage.subject = nil
    # @jivepage.edit_sessions.create(:user => @pmark)
    # @jivepage.heading.should == correct
  end
  
end


describe Jivepage, "updating structure or content" do
  before(:each) do
    @jivepage = Jivepage.create!
  end
  
  it "should set width and sidebar to default if empty" do
    @jivepage.width.should == Jivepage::COMPACT_LAYOUT
    @jivepage.sidebar.should == Jivepage::NO_SIDEBAR
  end
  
  it "should set #skin properly when #sidebar is 'none'" do
    @jivepage.skin = nil
    @jivepage.sidebar = Jivepage::NO_SIDEBAR
    @jivepage.save
    @jivepage.skin.should be_nil
  end
  
  it "should set #layout and #skin properly when #width is set to 'compact' and #sidebar is 'left'" do
    @jivepage.layout = nil
    @jivepage.skin = nil
    @jivepage.width = Jivepage::COMPACT_LAYOUT
    @jivepage.sidebar = Jivepage::LEFT_SIDEBAR
    @jivepage.save
    @jivepage.layout.should == "doc"
    @jivepage.skin.should == "yui-t2"
  end
  
  it "should set #layout and #skin properly when #width is set to 'compact' and #sidebar is 'right'" do
    @jivepage.layout = nil
    @jivepage.skin = nil
    @jivepage.width = Jivepage::COMPACT_LAYOUT
    @jivepage.sidebar = Jivepage::RIGHT_SIDEBAR
    @jivepage.save
    @jivepage.layout.should == "doc"
    @jivepage.skin.should == "yui-t4"
  end
  
  it "should set #layout and #skin properly when #width is 'fluid' and #sidebar is 'left'" do
    @jivepage.layout = nil
    @jivepage.skin = nil
    @jivepage.width = Jivepage::FLUID_LAYOUT
    @jivepage.sidebar = Jivepage::LEFT_SIDEBAR
    @jivepage.save
    @jivepage.layout.should == "doc3"
    @jivepage.skin.should == "yui-t3"
  end
  
  it "should set #layout and #skin properly when #width is 'fluid' and #sidebar is 'right'" do
    @jivepage.layout = nil
    @jivepage.skin = nil
    @jivepage.width = Jivepage::FLUID_LAYOUT
    @jivepage.sidebar = Jivepage::RIGHT_SIDEBAR
    @jivepage.save
    @jivepage.layout.should == "doc3"
    @jivepage.skin.should == "yui-t6"
  end
  
  it "should set #layout and #skin properly when #width is 'wide' and #sidebar is 'left'" do
    @jivepage.layout = nil
    @jivepage.skin = nil
    @jivepage.width = Jivepage::WIDE_LAYOUT
    @jivepage.sidebar = Jivepage::LEFT_SIDEBAR
    @jivepage.save
    @jivepage.layout.should == "doc4"
    @jivepage.skin.should == "yui-t3"
  end
  
  it "should set #layout and #skin properly when #width is 'wide' and #sidebar is 'left'" do
    @jivepage.layout = nil
    @jivepage.skin = nil
    @jivepage.width = Jivepage::WIDE_LAYOUT
    @jivepage.sidebar = Jivepage::LEFT_SIDEBAR
    @jivepage.save
    @jivepage.layout.should == "doc4"
    @jivepage.skin.should == "yui-t3"
  end
  
end













