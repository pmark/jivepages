class PageChangesController < ApplicationController
  # GET /page_changes
  # GET /page_changes.xml
  def index
    @page_changes = PageChange.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page_changes }
    end
  end

  # GET /page_changes/1
  # GET /page_changes/1.xml
  def show
    @page_change = PageChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page_change }
    end
  end

  # GET /page_changes/new
  # GET /page_changes/new.xml
  def new
    @page_change = PageChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page_change }
    end
  end

  # GET /page_changes/1/edit
  def edit
    @page_change = PageChange.find(params[:id])
  end

  # POST /page_changes
  # POST /page_changes.xml
  def create
    @page_change = PageChange.new(params[:page_change])

    respond_to do |format|
      if @page_change.save
        flash[:notice] = 'PageChange was successfully created.'
        format.html { redirect_to(@page_change) }
        format.xml  { render :xml => @page_change, :status => :created, :location => @page_change }
        format.js do
          render :update do |page|
            page.call "marker_buffer.sent"
          end
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page_change.errors, :status => :unprocessable_entity }
        format.js do
          render :update do |page| 
            page.alert("Sorry: #{@page_change.errors.full_messages})" 
          end
        end
      end
    end
  end

  # PUT /page_changes/1
  # PUT /page_changes/1.xml
  def update
    @page_change = PageChange.find(params[:id])

    respond_to do |format|
      if @page_change.update_attributes(params[:page_change])
        flash[:notice] = 'PageChange was successfully updated.'
        format.html { redirect_to(@page_change) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /page_changes/1
  # DELETE /page_changes/1.xml
  def destroy
    @page_change = PageChange.find(params[:id])
    @page_change.destroy

    respond_to do |format|
      format.html { redirect_to(page_changes_url) }
      format.xml  { head :ok }
    end
  end
end
