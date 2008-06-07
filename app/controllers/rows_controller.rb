class RowsController < ApplicationController
  helper :jivepages
  
  
  def update
    @row = Row.find(params[:id])

    respond_to do |format|
      if @row.update_attributes(params[:row])
        flash[:notice] = 'Row was successfully updated.'
        
        
        format.html { redirect_to(@row) }
        format.xml  { head :ok }
        format.js   {
          column_content = if @row.columns.size == 1
            @column = @row.columns.first
            render_to_string(:template => "columns/_content.html.erb")
          else
            @row.columns.collect do |column|
              @column = column
              render_to_string(:template => "columns/_column.html.erb")
            end.join("\n")
          end
          
          render :update do |page|
            page.replace_html dom_id(@row, "container"), column_content
            page.call "Row.change_grid_type", @row.dom_id, @row.yui_grid_type
          end
        }        
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @row.errors, :status => :unprocessable_entity }
        format.js   {
          render :update do |page|
            page.alert("Sorry, there was a problem: #{@row.errors.full_messages}")
          end
        }
      end
    end
  end
  
  def up
    move(params[:id], Row::UP)
  end
  
  def down
    move(params[:id], Row::DOWN)
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
    begin
      jivepage = Jivepage.find(params[:jivepage_id])
      row = jivepage.rows.create!(params[:row])
      anchor_row = Row.find(params[:anchor_row_id])      
      row.insert_at(anchor_row.position + 1)

      respond_to do |format|
        flash[:notice] = 'Row was successfully created.'
        format.html { redirect_to(row) }
        format.xml  { render :xml => row, :status => :created, :location => row }
        format.js   { 
          render :update do |page|
            page.insert_html :after, anchor_row.dom_id, 
                :partial => "rows/row", :locals => {:row => row}
            page.call "Row.setup", row.dom_id
            # page.call "Element.scrollTo", row.dom_id
            # page.visual_effect :highlight, row.dom_id
          end
        }      
      end
    rescue
      row.errors.add_to_base($!)
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => row.errors, :status => :unprocessable_entity }
        format.js   { 
          render :update do |page|
            page.alert "Sorry, there was a problem adding a row.  #{$!}"
          end
        }
      end
    end
  end

  def destroy
    begin
      row = Row.find(params[:id])
      if row.first? and row.last?
        raise "This is the only row in the #{row.section} section."
      end
      row.destroy

      respond_to do |format|
        format.html { redirect_to(rows_url) }
        format.xml  { head :ok }
        format.js   { 
          render :update do |page|
            page.call "Row.fix_first", row.section
          end
        } 
      end
    rescue
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => row.errors, :status => :unprocessable_entity }
        format.js   { 
          render :update do |page|
            page.alert "#{$!}"
          end
        }
      end
    end
  end
  
  protected    
    def move(row_id, dir)
      begin
        row = Row.find(row_id)
        was_first = row.first?
        raise "Unable to reposition." unless row.move(dir)

        respond_to do |format|
          flash[:notice] = 'Row was successfully moved.'
          format.html { redirect_to(row) }
          format.xml  { render :xml => row, :status => :created, :location => row }
          format.js   { 
            render :update do |page|
              page.call "Row.fix_first", row.section
              page.call "Row.unhover_all"
              page.call "Element.scrollTo", row.dom_id
            end
          }
        end
      rescue
        row.errors.add_to_base($!)
        respond_to do |format|
          format.html { render :action => "new" }
          format.xml  { render :xml => row.errors, :status => :unprocessable_entity }
          format.js   { 
            render :update do |page|
              page.alert "Sorry, there was a problem moving that row.  #{$!}"
            end
          }
        end
      end
    end
end
