require File.dirname(__FILE__) + '/../spec_helper'

describe JivepagesController do
  describe "handling GET /jivepages" do

    before(:each) do
      @jivepage = mock_model(Jivepage)
      Jivepage.stub!(:find).and_return([@jivepage])
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
  
    it "should find all jivepages" do
      Jivepage.should_receive(:find).with(:all).and_return([@jivepage])
      do_get
    end
  
    it "should assign the found jivepages for the view" do
      do_get
      assigns[:jivepages].should == [@jivepage]
    end
  end

  describe "handling GET /jivepages.xml" do

    before(:each) do
      @jivepages = mock("Array of Jivepages", :to_xml => "XML")
      Jivepage.stub!(:find).and_return(@jivepages)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all jivepages" do
      Jivepage.should_receive(:find).with(:all).and_return(@jivepages)
      do_get
    end
  
    it "should render the found jivepages as xml" do
      @jivepages.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /jivepages/1" do

    before(:each) do
      @jivepage = mock_model(Jivepage)
      Jivepage.stub!(:find).and_return(@jivepage)
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
  
    it "should find the jivepage requested" do
      Jivepage.should_receive(:find).with("1").and_return(@jivepage)
      do_get
    end
  
    it "should assign the found jivepage for the view" do
      do_get
      assigns[:jivepage].should equal(@jivepage)
    end
  end

  describe "handling GET /jivepages/1.xml" do

    before(:each) do
      @jivepage = mock_model(Jivepage, :to_xml => "XML")
      Jivepage.stub!(:find).and_return(@jivepage)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the jivepage requested" do
      Jivepage.should_receive(:find).with("1").and_return(@jivepage)
      do_get
    end
  
    it "should render the found jivepage as xml" do
      @jivepage.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /jivepages/new" do

    before(:each) do
      @jivepage = mock_model(Jivepage)
      Jivepage.stub!(:new).and_return(@jivepage)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end  
  end

  describe "handling GET /jivepages/1/edit" do

    before(:each) do
      @jivepage = mock_model(Jivepage)
      Jivepage.stub!(:find).and_return(@jivepage)
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
  
    it "should find the jivepage requested" do
      Jivepage.should_receive(:find).and_return(@jivepage)
      do_get
    end
  
    it "should assign the found Jivepage for the view" do
      do_get
      assigns[:jivepage].should equal(@jivepage)
    end
  end

  describe "handling POST /jivepages" do

    before(:each) do
      @jivepage = mock_model(Jivepage, :to_param => "1")
      Jivepage.stub!(:new).and_return(@jivepage)
    end
    
    describe "with successful save" do
  
      def do_post
        @jivepage.should_receive(:save).and_return(true)
        post :create, :jivepage => {}
      end
  
      it "should create a new jivepage" do
        Jivepage.should_receive(:new).with({}).and_return(@jivepage)
        do_post
      end

      it "should redirect to the new jivepage" do
        do_post
        response.should redirect_to(jivepage_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @jivepage.should_receive(:save).and_return(false)
        post :create, :jivepage => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /jivepages/1" do

    before(:each) do
      @jivepage = mock_model(Jivepage, :to_param => "1")
      Jivepage.stub!(:find).and_return(@jivepage)
    end
    
    describe "with successful update" do

      def do_put
        @jivepage.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the jivepage requested" do
        Jivepage.should_receive(:find).with("1").and_return(@jivepage)
        do_put
      end

      it "should update the found jivepage" do
        do_put
        assigns(:jivepage).should equal(@jivepage)
      end

      it "should assign the found jivepage for the view" do
        do_put
        assigns(:jivepage).should equal(@jivepage)
      end

      it "should redirect to the jivepage" do
        do_put
        response.should redirect_to(jivepage_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @jivepage.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /jivepages/1" do

    before(:each) do
      @jivepage = mock_model(Jivepage, :destroy => true)
      Jivepage.stub!(:find).and_return(@jivepage)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the jivepage requested" do
      Jivepage.should_receive(:find).with("1").and_return(@jivepage)
      do_delete
    end
  
    it "should call destroy on the found jivepage" do
      @jivepage.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the jivepages list" do
      do_delete
      response.should redirect_to(jivepages_url)
    end
  end
end