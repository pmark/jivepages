require File.dirname(__FILE__) + '/../spec_helper'

describe ContributorshipsController do
  describe "route generation" do

    it "should map { :controller => 'contributorships', :action => 'index' } to /contributorships" do
      route_for(:controller => "contributorships", :action => "index").should == "/contributorships"
    end
  
    it "should map { :controller => 'contributorships', :action => 'new' } to /contributorships/new" do
      route_for(:controller => "contributorships", :action => "new").should == "/contributorships/new"
    end
  
    it "should map { :controller => 'contributorships', :action => 'show', :id => 1 } to /contributorships/1" do
      route_for(:controller => "contributorships", :action => "show", :id => 1).should == "/contributorships/1"
    end
  
    it "should map { :controller => 'contributorships', :action => 'edit', :id => 1 } to /contributorships/1/edit" do
      route_for(:controller => "contributorships", :action => "edit", :id => 1).should == "/contributorships/1/edit"
    end
  
    it "should map { :controller => 'contributorships', :action => 'update', :id => 1} to /contributorships/1" do
      route_for(:controller => "contributorships", :action => "update", :id => 1).should == "/contributorships/1"
    end
  
    it "should map { :controller => 'contributorships', :action => 'destroy', :id => 1} to /contributorships/1" do
      route_for(:controller => "contributorships", :action => "destroy", :id => 1).should == "/contributorships/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'contributorships', action => 'index' } from GET /contributorships" do
      params_from(:get, "/contributorships").should == {:controller => "contributorships", :action => "index"}
    end
  
    it "should generate params { :controller => 'contributorships', action => 'new' } from GET /contributorships/new" do
      params_from(:get, "/contributorships/new").should == {:controller => "contributorships", :action => "new"}
    end
  
    it "should generate params { :controller => 'contributorships', action => 'create' } from POST /contributorships" do
      params_from(:post, "/contributorships").should == {:controller => "contributorships", :action => "create"}
    end
  
    it "should generate params { :controller => 'contributorships', action => 'show', id => '1' } from GET /contributorships/1" do
      params_from(:get, "/contributorships/1").should == {:controller => "contributorships", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'contributorships', action => 'edit', id => '1' } from GET /contributorships/1;edit" do
      params_from(:get, "/contributorships/1/edit").should == {:controller => "contributorships", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'contributorships', action => 'update', id => '1' } from PUT /contributorships/1" do
      params_from(:put, "/contributorships/1").should == {:controller => "contributorships", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'contributorships', action => 'destroy', id => '1' } from DELETE /contributorships/1" do
      params_from(:delete, "/contributorships/1").should == {:controller => "contributorships", :action => "destroy", :id => "1"}
    end
  end
end