class BoxesController < ApplicationController
  in_place_edit_for :box, :content
  
  # GET /boxes
  # GET /boxes.xml
  def index
    @boxes = Box.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boxes }
    end
  end

  # GET /boxes/1
  # GET /boxes/1.xml
  def show
    @box = Box.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @box }
    end
  end

  # GET /boxes/new
  # GET /boxes/new.xml
  def new
    @box = Box.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @box }
    end
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
  end

  # POST /boxes
  # POST /boxes.xml
  def create
    raise "Missing box[kind]" unless params[:box][:kind]
    @kind = params[:box].delete(:kind)
    begin
      box_class = @kind.constantize
      @box = box_class.new(params[:box])
      @box.jivepage = @box.cell.jivepage
    rescue
      raise "Problem creating new box of kind #{@kind}: #{$!}"
    end

    respond_to do |format|
      if @box.save!
        flash[:notice] = 'Box was successfully created.'
        format.html { redirect_to(@box) }
        format.xml  { render :xml => @box, :status => :created, :location => @box }
        format.js do
          render :update do |page|
          page.insert_html :bottom, "#{@box.cell.dom_id}-content", 
              :partial => "jivepages/box", :locals => {:box => @box}
          end
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @box.errors, :status => :unprocessable_entity }
        format.js do |page|
          page.alert "Sorry, that didn't work: #{@box.errors.full_messages}"
        end
      end
    end
  end

  # PUT /boxes/1
  # PUT /boxes/1.xml
  def update
    @box = Box.find(params[:id])

    respond_to do |format|
      if @box.update_attributes(params[:box])
        flash[:notice] = 'Box was successfully updated.'
        format.html { redirect_to(@box) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.xml
  def destroy
    @box = Box.find(params[:id])
    @box.destroy

    respond_to do |format|
      format.html { redirect_to(boxes_url) }
      format.xml  { head :ok }
    end
  end
end
