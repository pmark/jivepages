require File.dirname(__FILE__) + '/../spec_helper'

describe PageChangesController do
  describe "handling GET /page_changes" do

    before(:each) do
      @page_change = mock_model(PageChange)
      PageChange.stub!(:find).and_return([@page_change])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all page_changes" do
      PageChange.should_receive(:find).with(:all).and_return([@page_change])
      do_get
    end
  
    it "should assign the found page_changes for the view" do
      do_get
      assigns[:page_changes].should == [@page_change]
    end
  end

  describe "handling GET /page_changes.xml" do

    before(:each) do
      @page_changes = mock("Array of PageChanges", :to_xml => "XML")
      PageChange.stub!(:find).and_return(@page_changes)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all page_changes" do
      PageChange.should_receive(:find).with(:all).and_return(@page_changes)
      do_get
    end
  
    it "should render the found page_changes as xml" do
      @page_changes.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /page_changes/1" do

    before(:each) do
      @page_change = mock_model(PageChange)
      PageChange.stub!(:find).and_return(@page_change)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the page_change requested" do
      PageChange.should_receive(:find).with("1").and_return(@page_change)
      do_get
    end
  
    it "should assign the found page_change for the view" do
      do_get
      assigns[:page_change].should equal(@page_change)
    end
  end

  describe "handling GET /page_changes/1.xml" do

    before(:each) do
      @page_change = mock_model(PageChange, :to_xml => "XML")
      PageChange.stub!(:find).and_return(@page_change)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the page_change requested" do
      PageChange.should_receive(:find).with("1").and_return(@page_change)
      do_get
    end
  
    it "should render the found page_change as xml" do
      @page_change.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /page_changes/new" do

    before(:each) do
      @page_change = mock_model(PageChange)
      PageChange.stub!(:new).and_return(@page_change)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new page_change" do
      PageChange.should_receive(:new).and_return(@page_change)
      do_get
    end
  
    it "should not save the new page_change" do
      @page_change.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new page_change for the view" do
      do_get
      assigns[:page_change].should equal(@page_change)
    end
  end

  describe "handling GET /page_changes/1/edit" do

    before(:each) do
      @page_change = mock_model(PageChange)
      PageChange.stub!(:find).and_return(@page_change)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the page_change requested" do
      PageChange.should_receive(:find).and_return(@page_change)
      do_get
    end
  
    it "should assign the found PageChange for the view" do
      do_get
      assigns[:page_change].should equal(@page_change)
    end
  end

  describe "handling POST /page_changes" do

    before(:each) do
      @page_change = mock_model(PageChange, :to_param => "1")
      PageChange.stub!(:new).and_return(@page_change)
    end
    
    describe "with successful save" do
  
      def do_post
        @page_change.should_receive(:save).and_return(true)
        post :create, :page_change => {}
      end
  
      it "should create a new page_change" do
        PageChange.should_receive(:new).with({}).and_return(@page_change)
        do_post
      end

      it "should redirect to the new page_change" do
        do_post
        response.should redirect_to(page_change_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @page_change.should_receive(:save).and_return(false)
        post :create, :page_change => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /page_changes/1" do

    before(:each) do
      @page_change = mock_model(PageChange, :to_param => "1")
      PageChange.stub!(:find).and_return(@page_change)
    end
    
    describe "with successful update" do

      def do_put
        @page_change.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the page_change requested" do
        PageChange.should_receive(:find).with("1").and_return(@page_change)
        do_put
      end

      it "should update the found page_change" do
        do_put
        assigns(:page_change).should equal(@page_change)
      end

      it "should assign the found page_change for the view" do
        do_put
        assigns(:page_change).should equal(@page_change)
      end

      it "should redirect to the page_change" do
        do_put
        response.should redirect_to(page_change_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @page_change.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /page_changes/1" do

    before(:each) do
      @page_change = mock_model(PageChange, :destroy => true)
      PageChange.stub!(:find).and_return(@page_change)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the page_change requested" do
      PageChange.should_receive(:find).with("1").and_return(@page_change)
      do_delete
    end
  
    it "should call destroy on the found page_change" do
      @page_change.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the page_changes list" do
      do_delete
      response.should redirect_to(page_changes_url)
    end
  end
end