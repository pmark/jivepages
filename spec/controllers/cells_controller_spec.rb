require File.dirname(__FILE__) + '/../spec_helper'

describe CellsController do
  describe "handling GET /cells" do

    before(:each) do
      @cell = mock_model(Cell)
      Cell.stub!(:find).and_return([@cell])
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
  
    it "should find all cells" do
      Cell.should_receive(:find).with(:all).and_return([@cell])
      do_get
    end
  
    it "should assign the found cells for the view" do
      do_get
      assigns[:cells].should == [@cell]
    end
  end

  describe "handling GET /cells.xml" do

    before(:each) do
      @cells = mock("Array of Cells", :to_xml => "XML")
      Cell.stub!(:find).and_return(@cells)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all cells" do
      Cell.should_receive(:find).with(:all).and_return(@cells)
      do_get
    end
  
    it "should render the found cells as xml" do
      @cells.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /cells/1" do

    before(:each) do
      @cell = mock_model(Cell)
      Cell.stub!(:find).and_return(@cell)
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
  
    it "should find the cell requested" do
      Cell.should_receive(:find).with("1").and_return(@cell)
      do_get
    end
  
    it "should assign the found cell for the view" do
      do_get
      assigns[:cell].should equal(@cell)
    end
  end

  describe "handling GET /cells/1.xml" do

    before(:each) do
      @cell = mock_model(Cell, :to_xml => "XML")
      Cell.stub!(:find).and_return(@cell)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the cell requested" do
      Cell.should_receive(:find).with("1").and_return(@cell)
      do_get
    end
  
    it "should render the found cell as xml" do
      @cell.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /cells/new" do

    before(:each) do
      @cell = mock_model(Cell)
      Cell.stub!(:new).and_return(@cell)
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
  
    it "should create an new cell" do
      Cell.should_receive(:new).and_return(@cell)
      do_get
    end
  
    it "should not save the new cell" do
      @cell.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new cell for the view" do
      do_get
      assigns[:cell].should equal(@cell)
    end
  end

  describe "handling GET /cells/1/edit" do

    before(:each) do
      @cell = mock_model(Cell)
      Cell.stub!(:find).and_return(@cell)
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
  
    it "should find the cell requested" do
      Cell.should_receive(:find).and_return(@cell)
      do_get
    end
  
    it "should assign the found Cell for the view" do
      do_get
      assigns[:cell].should equal(@cell)
    end
  end

  describe "handling POST /cells" do

    before(:each) do
      @cell = mock_model(Cell, :to_param => "1")
      Cell.stub!(:new).and_return(@cell)
    end
    
    describe "with successful save" do
  
      def do_post
        @cell.should_receive(:save).and_return(true)
        post :create, :cell => {}
      end
  
      it "should create a new cell" do
        Cell.should_receive(:new).with({}).and_return(@cell)
        do_post
      end

      it "should redirect to the new cell" do
        do_post
        response.should redirect_to(cell_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @cell.should_receive(:save).and_return(false)
        post :create, :cell => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /cells/1" do

    before(:each) do
      @cell = mock_model(Cell, :to_param => "1")
      Cell.stub!(:find).and_return(@cell)
    end
    
    describe "with successful update" do

      def do_put
        @cell.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the cell requested" do
        Cell.should_receive(:find).with("1").and_return(@cell)
        do_put
      end

      it "should update the found cell" do
        do_put
        assigns(:cell).should equal(@cell)
      end

      it "should assign the found cell for the view" do
        do_put
        assigns(:cell).should equal(@cell)
      end

      it "should redirect to the cell" do
        do_put
        response.should redirect_to(cell_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @cell.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /cells/1" do

    before(:each) do
      @cell = mock_model(Cell, :destroy => true)
      Cell.stub!(:find).and_return(@cell)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the cell requested" do
      Cell.should_receive(:find).with("1").and_return(@cell)
      do_delete
    end
  
    it "should call destroy on the found cell" do
      @cell.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the cells list" do
      do_delete
      response.should redirect_to(cells_url)
    end
  end
end