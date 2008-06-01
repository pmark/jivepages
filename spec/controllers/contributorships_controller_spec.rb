require File.dirname(__FILE__) + '/../spec_helper'

describe ContributorshipsController do
  describe "handling GET /contributorships" do

    before(:each) do
      @contributorship = mock_model(Contributorship)
      Contributorship.stub!(:find).and_return([@contributorship])
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
  
    it "should find all contributorships" do
      Contributorship.should_receive(:find).with(:all).and_return([@contributorship])
      do_get
    end
  
    it "should assign the found contributorships for the view" do
      do_get
      assigns[:contributorships].should == [@contributorship]
    end
  end

  describe "handling GET /contributorships.xml" do

    before(:each) do
      @contributorships = mock("Array of Contributorships", :to_xml => "XML")
      Contributorship.stub!(:find).and_return(@contributorships)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all contributorships" do
      Contributorship.should_receive(:find).with(:all).and_return(@contributorships)
      do_get
    end
  
    it "should render the found contributorships as xml" do
      @contributorships.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /contributorships/1" do

    before(:each) do
      @contributorship = mock_model(Contributorship)
      Contributorship.stub!(:find).and_return(@contributorship)
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
  
    it "should find the contributorship requested" do
      Contributorship.should_receive(:find).with("1").and_return(@contributorship)
      do_get
    end
  
    it "should assign the found contributorship for the view" do
      do_get
      assigns[:contributorship].should equal(@contributorship)
    end
  end

  describe "handling GET /contributorships/1.xml" do

    before(:each) do
      @contributorship = mock_model(Contributorship, :to_xml => "XML")
      Contributorship.stub!(:find).and_return(@contributorship)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the contributorship requested" do
      Contributorship.should_receive(:find).with("1").and_return(@contributorship)
      do_get
    end
  
    it "should render the found contributorship as xml" do
      @contributorship.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /contributorships/new" do

    before(:each) do
      @contributorship = mock_model(Contributorship)
      Contributorship.stub!(:new).and_return(@contributorship)
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
  
    it "should create an new contributorship" do
      Contributorship.should_receive(:new).and_return(@contributorship)
      do_get
    end
  
    it "should not save the new contributorship" do
      @contributorship.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new contributorship for the view" do
      do_get
      assigns[:contributorship].should equal(@contributorship)
    end
  end

  describe "handling GET /contributorships/1/edit" do

    before(:each) do
      @contributorship = mock_model(Contributorship)
      Contributorship.stub!(:find).and_return(@contributorship)
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
  
    it "should find the contributorship requested" do
      Contributorship.should_receive(:find).and_return(@contributorship)
      do_get
    end
  
    it "should assign the found Contributorship for the view" do
      do_get
      assigns[:contributorship].should equal(@contributorship)
    end
  end

  describe "handling POST /contributorships" do

    before(:each) do
      @contributorship = mock_model(Contributorship, :to_param => "1")
      Contributorship.stub!(:new).and_return(@contributorship)
    end
    
    describe "with successful save" do
  
      def do_post
        @contributorship.should_receive(:save).and_return(true)
        post :create, :contributorship => {}
      end
  
      it "should create a new contributorship" do
        Contributorship.should_receive(:new).with({}).and_return(@contributorship)
        do_post
      end

      it "should redirect to the new contributorship" do
        do_post
        response.should redirect_to(contributorship_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @contributorship.should_receive(:save).and_return(false)
        post :create, :contributorship => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /contributorships/1" do

    before(:each) do
      @contributorship = mock_model(Contributorship, :to_param => "1")
      Contributorship.stub!(:find).and_return(@contributorship)
    end
    
    describe "with successful update" do

      def do_put
        @contributorship.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the contributorship requested" do
        Contributorship.should_receive(:find).with("1").and_return(@contributorship)
        do_put
      end

      it "should update the found contributorship" do
        do_put
        assigns(:contributorship).should equal(@contributorship)
      end

      it "should assign the found contributorship for the view" do
        do_put
        assigns(:contributorship).should equal(@contributorship)
      end

      it "should redirect to the contributorship" do
        do_put
        response.should redirect_to(contributorship_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @contributorship.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /contributorships/1" do

    before(:each) do
      @contributorship = mock_model(Contributorship, :destroy => true)
      Contributorship.stub!(:find).and_return(@contributorship)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the contributorship requested" do
      Contributorship.should_receive(:find).with("1").and_return(@contributorship)
      do_delete
    end
  
    it "should call destroy on the found contributorship" do
      @contributorship.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the contributorships list" do
      do_delete
      response.should redirect_to(contributorships_url)
    end
  end
end