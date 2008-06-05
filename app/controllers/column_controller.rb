class ColumnsController < ApplicationController
  
  def index
    @columns = Column.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @columns }
    end
  end

  def create
    begin
      sibling = Column.find(params[:anchor_column_id])
    rescue
      respond_to do |format|
        msg = "Couldn't find column to insert #{position.to_s}"
        @column.errors.add_to_base(msg)
        flash[:error] = msg
        format.html { render :action => "new" }
        format.xml  { render :xml => @column.errors, :status => :unprocessable_entity }
        format.js do
          render :update do |page| page.alert(msg) end
        end
      end
      return
    end

    insert_above = ["true", true, 1, "1"].include?(params[:above])
    position = insert_above ? :before : :after
    
    @column = Column.new(params[:column])    
    
    respond_to do |format|
      if @column.anchor_to_sibling(sibling, position)        
        flash[:notice] = 'Column was successfully created.'
        format.html { redirect_to(@column) }
        format.xml  { render :xml => @column, :status => :created, :location => @column }
        format.js do
          render :update do |page|
            page.insert_html position, sibling.dom_id, 
                :partial => "/columns/grid", :locals => {:column => @column}
            page.call "Column.setup_columns", @column.dom_id
            page.call "Tool.close_all"
          end
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @column.errors, :status => :unprocessable_entity }
        format.js   { 
          render :update do |page|
            page.alert "Sorry, there was a problem inserting a row: #{@column.errors.full_messages}"
          end
        }
      end
    end
  end

  def update
    @column = Column.find(params[:id])
    respond_to do |format|
      if @column.update_attributes(params[:column])
        flash[:notice] = 'Column was successfully updated.'
        format.html { redirect_to(@column) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @column.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @column = Column.find(params[:id])
    respond_to do |format|
      if @column.siblings.blank?
        format.js do
          render :update do |page|
            page.alert "Probably don't want to do that."
          end
        end      
        
      else
        @column.destroy
        format.html { redirect_to(columns_url) }
        format.xml  { head :ok }
        format.js do
          render :update do |page| 
            page.remove @column.dom_id
          end
        end      
      end
    end
  end
  
  def new
    @column = Column.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @column }
    end
  end

  def edit
    @column = Column.find(params[:id])
  end
  
  def show
    @column = Column.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @column }
    end
  end

end
