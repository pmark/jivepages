module JivepagesHelper
  #
  #
  #
  def dom_id(o, suffix=nil)
    return unless o     
    o.class.name.underscore + (suffix ? "-#{suffix}" : '')    
  end
  
  def render_one_cell(cell, options={}, &block)   
    @cell = cell
    block_to_partial("cell", options.merge(:cell => cell), &block)    
  end
  
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    concat(render(:partial => partial_name, :locals => options), block.binding)
  end
  
  def render_box(box, state)
    return unless box.cell_kind
    render_cell box.cell_name.to_sym, state, box.cell_options
  end
  
  def rows_for(section, jivepage)
    render :partial => "/rows/row", 
        :collection => jivepage.rows.send("in_#{section.to_s}")
  end
  
  def columns_for(row)
    if row.columns.size == 1
      render :partial => "columns/content", :locals => {:column => row.columns.first}
    else
      content_tag(:div, :id => dom_id(row, "content"), :class => "column_list") do
        render :partial => "/columns/column", :collection => row.columns
      end
    end
  end
  
  def grid_for(row)
    render :partial => "/rows/grid", :collection => row.columns
  end
  
  def plugin_image_path(file_name)
    "/plugin_assets/jivepages/images/#{file_name}"
  end
  
  def page_user
    defined?(current_user) ? current_user : nil
  end
  
  # type can be :row or :column
  def tool_shed(o)
    type = o.class.name.downcase
    render :partial => "#{type.to_s}s/tool_shed", :locals => {type => o}
  end

end
