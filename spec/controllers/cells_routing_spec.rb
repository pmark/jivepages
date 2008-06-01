require File.dirname(__FILE__) + '/../spec_helper'

describe CellsController do
  describe "route generation" do

    it "should map { :controller => 'cells', :action => 'index' } to /cells" do
      route_for(:controller => "cells", :action => "index").should == "/cells"
    end
  
    it "should map { :controller => 'cells', :action => 'new' } to /cells/new" do
      route_for(:controller => "cells", :action => "new").should == "/cells/new"
    end
  
    it "should map { :controller => 'cells', :action => 'show', :id => 1 } to /cells/1" do
      route_for(:controller => "cells", :action => "show", :id => 1).should == "/cells/1"
    end
  
    it "should map { :controller => 'cells', :action => 'edit', :id => 1 } to /cells/1/edit" do
      route_for(:controller => "cells", :action => "edit", :id => 1).should == "/cells/1/edit"
    end
  
    it "should map { :controller => 'cells', :action => 'update', :id => 1} to /cells/1" do
      route_for(:controller => "cells", :action => "update", :id => 1).should == "/cells/1"
    end
  
    it "should map { :controller => 'cells', :action => 'destroy', :id => 1} to /cells/1" do
      route_for(:controller => "cells", :action => "destroy", :id => 1).should == "/cells/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'cells', action => 'index' } from GET /cells" do
      params_from(:get, "/cells").should == {:controller => "cells", :action => "index"}
    end
  
    it "should generate params { :controller => 'cells', action => 'new' } from GET /cells/new" do
      params_from(:get, "/cells/new").should == {:controller => "cells", :action => "new"}
    end
  
    it "should generate params { :controller => 'cells', action => 'create' } from POST /cells" do
      params_from(:post, "/cells").should == {:controller => "cells", :action => "create"}
    end
  
    it "should generate params { :controller => 'cells', action => 'show', id => '1' } from GET /cells/1" do
      params_from(:get, "/cells/1").should == {:controller => "cells", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'cells', action => 'edit', id => '1' } from GET /cells/1;edit" do
      params_from(:get, "/cells/1/edit").should == {:controller => "cells", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'cells', action => 'update', id => '1' } from PUT /cells/1" do
      params_from(:put, "/cells/1").should == {:controller => "cells", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'cells', action => 'destroy', id => '1' } from DELETE /cells/1" do
      params_from(:delete, "/cells/1").should == {:controller => "cells", :action => "destroy", :id => "1"}
    end
  end
end