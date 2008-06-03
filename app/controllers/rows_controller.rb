class RowsController < ApplicationController
  helper :jivepages
  
  
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
    
  def format_shouldnt_be_necessary_just_use_update
    @row = Row.find params[:id]
    grid_type = params[:grid_type]
    if grid_type == @row.grid_type
      render :nothing => true
      return
    end
    
    @row.change_grid_type(grid_type)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @row.to_xml }
      format.js do
        render :update do |page|
          page.replace @row.dom_id, :partial => "/rows/row", 
              :locals => {:column => @row}
        end
      end      
    end
  end
  
  def index
    @rows = Row.find(:all)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @rows }
    end
  end

  def show
    @row = Row.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @row }
    end
  end

  def new
    @row = Row.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @row }
    end
  end

  def edit
    @row = Row.find(params[:id])
  end

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

  def destroy
    @row = Row.find(params[:id])
    @row.destroy

    respond_to do |format|
      format.html { redirect_to(rows_url) }
      format.xml  { head :ok }
    end
  end
end
