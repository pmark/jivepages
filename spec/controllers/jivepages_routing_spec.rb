require File.dirname(__FILE__) + '/../spec_helper'

describe JivepagesController do
  describe "route generation" do

    it "should map { :controller => 'jivepages', :action => 'index' } to /jivepages" do
      route_for(:controller => "jivepages", :action => "index").should == "/jivepages"
    end
  
    it "should map { :controller => 'jivepages', :action => 'new' } to /jivepages/new" do
      route_for(:controller => "jivepages", :action => "new").should == "/jivepages/new"
    end
  
    it "should map { :controller => 'jivepages', :action => 'show', :id => 1 } to /jivepages/1" do
      route_for(:controller => "jivepages", :action => "show", :id => 1).should == "/jivepages/1"
    end
  
    it "should map { :controller => 'jivepages', :action => 'edit', :id => 1 } to /jivepages/1/edit" do
      route_for(:controller => "jivepages", :action => "edit", :id => 1).should == "/jivepages/1/edit"
    end
  
    it "should map { :controller => 'jivepages', :action => 'update', :id => 1} to /jivepages/1" do
      route_for(:controller => "jivepages", :action => "update", :id => 1).should == "/jivepages/1"
    end
  
    it "should map { :controller => 'jivepages', :action => 'destroy', :id => 1} to /jivepages/1" do
      route_for(:controller => "jivepages", :action => "destroy", :id => 1).should == "/jivepages/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'jivepages', action => 'index' } from GET /jivepages" do
      params_from(:get, "/jivepages").should == {:controller => "jivepages", :action => "index"}
    end
  
    it "should generate params { :controller => 'jivepages', action => 'new' } from GET /jivepages/new" do
      params_from(:get, "/jivepages/new").should == {:controller => "jivepages", :action => "new"}
    end
  
    it "should generate params { :controller => 'jivepages', action => 'create' } from POST /jivepages" do
      params_from(:post, "/jivepages").should == {:controller => "jivepages", :action => "create"}
    end
  
    it "should generate params { :controller => 'jivepages', action => 'show', id => '1' } from GET /jivepages/1" do
      params_from(:get, "/jivepages/1").should == {:controller => "jivepages", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'jivepages', action => 'edit', id => '1' } from GET /jivepages/1;edit" do
      params_from(:get, "/jivepages/1/edit").should == {:controller => "jivepages", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'jivepages', action => 'update', id => '1' } from PUT /jivepages/1" do
      params_from(:put, "/jivepages/1").should == {:controller => "jivepages", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'jivepages', action => 'destroy', id => '1' } from DELETE /jivepages/1" do
      params_from(:delete, "/jivepages/1").should == {:controller => "jivepages", :action => "destroy", :id => "1"}
    end
  end
end