class RowsController < ApplicationController
  # GET /rows
  # GET /rows.xml
  def index
    @rows = Row.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rows }
    end
  end

  # GET /rows/1
  # GET /rows/1.xml
  def show
    @row = Row.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @row }
    end
  end

  # GET /rows/new
  # GET /rows/new.xml
  def new
    @row = Row.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @row }
    end
  end

  # GET /rows/1/edit
  def edit
    @row = Row.find(params[:id])
  end

  # POST /rows
  # POST /rows.xml
  def create
    @row = Row.new(params[:row])

    respond_to do |format|
      if @row.save
        flash[:notice] = 'Row was successfully created.'
        format.html { redirect_to(@row) }
        format.xml  { render :xml => @row, :status => :created, :location => @row }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @row.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rows/1
  # PUT /rows/1.xml
  def update
    @row = Row.find(params[:id])

    respond_to do |format|
      if @row.update_attributes(params[:row])
        flash[:notice] = 'Row was successfully updated.'
        format.html { redirect_to(@row) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @row.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rows/1
  # DELETE /rows/1.xml
  def destroy
    @row = Row.find(params[:id])
    @row.destroy

    respond_to do |format|
      format.html { redirect_to(rows_url) }
      format.xml  { head :ok }
    end
  end
end
