require File.dirname(__FILE__) + '/../spec_helper'

describe EditSessionsController do
  describe "route generation" do

    it "should map { :controller => 'edit_sessions', :action => 'index' } to /edit_sessions" do
      route_for(:controller => "edit_sessions", :action => "index").should == "/edit_sessions"
    end
  
    it "should map { :controller => 'edit_sessions', :action => 'new' } to /edit_sessions/new" do
      route_for(:controller => "edit_sessions", :action => "new").should == "/edit_sessions/new"
    end
  
    it "should map { :controller => 'edit_sessions', :action => 'show', :id => 1 } to /edit_sessions/1" do
      route_for(:controller => "edit_sessions", :action => "show", :id => 1).should == "/edit_sessions/1"
    end
  
    it "should map { :controller => 'edit_sessions', :action => 'edit', :id => 1 } to /edit_sessions/1/edit" do
      route_for(:controller => "edit_sessions", :action => "edit", :id => 1).should == "/edit_sessions/1/edit"
    end
  
    it "should map { :controller => 'edit_sessions', :action => 'update', :id => 1} to /edit_sessions/1" do
      route_for(:controller => "edit_sessions", :action => "update", :id => 1).should == "/edit_sessions/1"
    end
  
    it "should map { :controller => 'edit_sessions', :action => 'destroy', :id => 1} to /edit_sessions/1" do
      route_for(:controller => "edit_sessions", :action => "destroy", :id => 1).should == "/edit_sessions/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'edit_sessions', action => 'index' } from GET /edit_sessions" do
      params_from(:get, "/edit_sessions").should == {:controller => "edit_sessions", :action => "index"}
    end
  
    it "should generate params { :controller => 'edit_sessions', action => 'new' } from GET /edit_sessions/new" do
      params_from(:get, "/edit_sessions/new").should == {:controller => "edit_sessions", :action => "new"}
    end
  
    it "should generate params { :controller => 'edit_sessions', action => 'create' } from POST /edit_sessions" do
      params_from(:post, "/edit_sessions").should == {:controller => "edit_sessions", :action => "create"}
    end
  
    it "should generate params { :controller => 'edit_sessions', action => 'show', id => '1' } from GET /edit_sessions/1" do
      params_from(:get, "/edit_sessions/1").should == {:controller => "edit_sessions", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'edit_sessions', action => 'edit', id => '1' } from GET /edit_sessions/1;edit" do
      params_from(:get, "/edit_sessions/1/edit").should == {:controller => "edit_sessions", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'edit_sessions', action => 'update', id => '1' } from PUT /edit_sessions/1" do
      params_from(:put, "/edit_sessions/1").should == {:controller => "edit_sessions", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'edit_sessions', action => 'destroy', id => '1' } from DELETE /edit_sessions/1" do
      params_from(:delete, "/edit_sessions/1").should == {:controller => "edit_sessions", :action => "destroy", :id => "1"}
    end
  end
end