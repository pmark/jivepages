require File.dirname(__FILE__) + '/../spec_helper'

describe BoxesController do
  describe "route generation" do

    it "should map { :controller => 'boxes', :action => 'index' } to /boxes" do
      route_for(:controller => "boxes", :action => "index").should == "/boxes"
    end
  
    it "should map { :controller => 'boxes', :action => 'new' } to /boxes/new" do
      route_for(:controller => "boxes", :action => "new").should == "/boxes/new"
    end
  
    it "should map { :controller => 'boxes', :action => 'show', :id => 1 } to /boxes/1" do
      route_for(:controller => "boxes", :action => "show", :id => 1).should == "/boxes/1"
    end
  
    it "should map { :controller => 'boxes', :action => 'edit', :id => 1 } to /boxes/1/edit" do
      route_for(:controller => "boxes", :action => "edit", :id => 1).should == "/boxes/1/edit"
    end
  
    it "should map { :controller => 'boxes', :action => 'update', :id => 1} to /boxes/1" do
      route_for(:controller => "boxes", :action => "update", :id => 1).should == "/boxes/1"
    end
  
    it "should map { :controller => 'boxes', :action => 'destroy', :id => 1} to /boxes/1" do
      route_for(:controller => "boxes", :action => "destroy", :id => 1).should == "/boxes/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'boxes', action => 'index' } from GET /boxes" do
      params_from(:get, "/boxes").should == {:controller => "boxes", :action => "index"}
    end
  
    it "should generate params { :controller => 'boxes', action => 'new' } from GET /boxes/new" do
      params_from(:get, "/boxes/new").should == {:controller => "boxes", :action => "new"}
    end
  
    it "should generate params { :controller => 'boxes', action => 'create' } from POST /boxes" do
      params_from(:post, "/boxes").should == {:controller => "boxes", :action => "create"}
    end
  
    it "should generate params { :controller => 'boxes', action => 'show', id => '1' } from GET /boxes/1" do
      params_from(:get, "/boxes/1").should == {:controller => "boxes", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'boxes', action => 'edit', id => '1' } from GET /boxes/1;edit" do
      params_from(:get, "/boxes/1/edit").should == {:controller => "boxes", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'boxes', action => 'update', id => '1' } from PUT /boxes/1" do
      params_from(:put, "/boxes/1").should == {:controller => "boxes", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'boxes', action => 'destroy', id => '1' } from DELETE /boxes/1" do
      params_from(:delete, "/boxes/1").should == {:controller => "boxes", :action => "destroy", :id => "1"}
    end
  end
end