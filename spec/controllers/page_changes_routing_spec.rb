require File.dirname(__FILE__) + '/../spec_helper'

describe PageChangesController do
  describe "route generation" do

    it "should map { :controller => 'page_changes', :action => 'index' } to /page_changes" do
      route_for(:controller => "page_changes", :action => "index").should == "/page_changes"
    end
  
    it "should map { :controller => 'page_changes', :action => 'new' } to /page_changes/new" do
      route_for(:controller => "page_changes", :action => "new").should == "/page_changes/new"
    end
  
    it "should map { :controller => 'page_changes', :action => 'show', :id => 1 } to /page_changes/1" do
      route_for(:controller => "page_changes", :action => "show", :id => 1).should == "/page_changes/1"
    end
  
    it "should map { :controller => 'page_changes', :action => 'edit', :id => 1 } to /page_changes/1/edit" do
      route_for(:controller => "page_changes", :action => "edit", :id => 1).should == "/page_changes/1/edit"
    end
  
    it "should map { :controller => 'page_changes', :action => 'update', :id => 1} to /page_changes/1" do
      route_for(:controller => "page_changes", :action => "update", :id => 1).should == "/page_changes/1"
    end
  
    it "should map { :controller => 'page_changes', :action => 'destroy', :id => 1} to /page_changes/1" do
      route_for(:controller => "page_changes", :action => "destroy", :id => 1).should == "/page_changes/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'page_changes', action => 'index' } from GET /page_changes" do
      params_from(:get, "/page_changes").should == {:controller => "page_changes", :action => "index"}
    end
  
    it "should generate params { :controller => 'page_changes', action => 'new' } from GET /page_changes/new" do
      params_from(:get, "/page_changes/new").should == {:controller => "page_changes", :action => "new"}
    end
  
    it "should generate params { :controller => 'page_changes', action => 'create' } from POST /page_changes" do
      params_from(:post, "/page_changes").should == {:controller => "page_changes", :action => "create"}
    end
  
    it "should generate params { :controller => 'page_changes', action => 'show', id => '1' } from GET /page_changes/1" do
      params_from(:get, "/page_changes/1").should == {:controller => "page_changes", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'page_changes', action => 'edit', id => '1' } from GET /page_changes/1;edit" do
      params_from(:get, "/page_changes/1/edit").should == {:controller => "page_changes", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'page_changes', action => 'update', id => '1' } from PUT /page_changes/1" do
      params_from(:put, "/page_changes/1").should == {:controller => "page_changes", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'page_changes', action => 'destroy', id => '1' } from DELETE /page_changes/1" do
      params_from(:delete, "/page_changes/1").should == {:controller => "page_changes", :action => "destroy", :id => "1"}
    end
  end
end