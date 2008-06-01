require File.dirname(__FILE__) + '/../spec_helper'

describe EditSessionsController do
  describe "handling GET /edit_sessions" do

    before(:each) do
      @edit_session = mock_model(EditSession)
      EditSession.stub!(:find).and_return([@edit_session])
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
  
    it "should find all edit_sessions" do
      EditSession.should_receive(:find).with(:all).and_return([@edit_session])
      do_get
    end
  
    it "should assign the found edit_sessions for the view" do
      do_get
      assigns[:edit_sessions].should == [@edit_session]
    end
  end

  describe "handling GET /edit_sessions.xml" do

    before(:each) do
      @edit_sessions = mock("Array of EditSessions", :to_xml => "XML")
      EditSession.stub!(:find).and_return(@edit_sessions)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all edit_sessions" do
      EditSession.should_receive(:find).with(:all).and_return(@edit_sessions)
      do_get
    end
  
    it "should render the found edit_sessions as xml" do
      @edit_sessions.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /edit_sessions/1" do

    before(:each) do
      @edit_session = mock_model(EditSession)
      EditSession.stub!(:find).and_return(@edit_session)
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
  
    it "should find the edit_session requested" do
      EditSession.should_receive(:find).with("1").and_return(@edit_session)
      do_get
    end
  
    it "should assign the found edit_session for the view" do
      do_get
      assigns[:edit_session].should equal(@edit_session)
    end
  end

  describe "handling GET /edit_sessions/1.xml" do

    before(:each) do
      @edit_session = mock_model(EditSession, :to_xml => "XML")
      EditSession.stub!(:find).and_return(@edit_session)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the edit_session requested" do
      EditSession.should_receive(:find).with("1").and_return(@edit_session)
      do_get
    end
  
    it "should render the found edit_session as xml" do
      @edit_session.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /edit_sessions/new" do

    before(:each) do
      @edit_session = mock_model(EditSession)
      EditSession.stub!(:new).and_return(@edit_session)
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
  
    it "should create an new edit_session" do
      EditSession.should_receive(:new).and_return(@edit_session)
      do_get
    end
  
    it "should not save the new edit_session" do
      @edit_session.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new edit_session for the view" do
      do_get
      assigns[:edit_session].should equal(@edit_session)
    end
  end

  describe "handling GET /edit_sessions/1/edit" do

    before(:each) do
      @edit_session = mock_model(EditSession)
      EditSession.stub!(:find).and_return(@edit_session)
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
  
    it "should find the edit_session requested" do
      EditSession.should_receive(:find).and_return(@edit_session)
      do_get
    end
  
    it "should assign the found EditSession for the view" do
      do_get
      assigns[:edit_session].should equal(@edit_session)
    end
  end

  describe "handling POST /edit_sessions" do

    before(:each) do
      @edit_session = mock_model(EditSession, :to_param => "1")
      EditSession.stub!(:new).and_return(@edit_session)
    end
    
    describe "with successful save" do
  
      def do_post
        @edit_session.should_receive(:save).and_return(true)
        post :create, :edit_session => {}
      end
  
      it "should create a new edit_session" do
        EditSession.should_receive(:new).with({}).and_return(@edit_session)
        do_post
      end

      it "should redirect to the new edit_session" do
        do_post
        response.should redirect_to(edit_session_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @edit_session.should_receive(:save).and_return(false)
        post :create, :edit_session => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /edit_sessions/1" do

    before(:each) do
      @edit_session = mock_model(EditSession, :to_param => "1")
      EditSession.stub!(:find).and_return(@edit_session)
    end
    
    describe "with successful update" do

      def do_put
        @edit_session.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the edit_session requested" do
        EditSession.should_receive(:find).with("1").and_return(@edit_session)
        do_put
      end

      it "should update the found edit_session" do
        do_put
        assigns(:edit_session).should equal(@edit_session)
      end

      it "should assign the found edit_session for the view" do
        do_put
        assigns(:edit_session).should equal(@edit_session)
      end

      it "should redirect to the edit_session" do
        do_put
        response.should redirect_to(edit_session_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @edit_session.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /edit_sessions/1" do

    before(:each) do
      @edit_session = mock_model(EditSession, :destroy => true)
      EditSession.stub!(:find).and_return(@edit_session)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the edit_session requested" do
      EditSession.should_receive(:find).with("1").and_return(@edit_session)
      do_delete
    end
  
    it "should call destroy on the found edit_session" do
      @edit_session.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the edit_sessions list" do
      do_delete
      response.should redirect_to(edit_sessions_url)
    end
  end
end