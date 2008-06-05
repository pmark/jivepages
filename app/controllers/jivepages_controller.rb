class JivepagesController < ApplicationController
  # before_filter :login_required, :only => [:create, :update, :edit]
  before_filter :find_jivepage, :only => [:show, :edit, :update, :destroy]
  # before_filter :load_box_classes, :only => [:show, :edit]
  # before_filter :append_box_view_paths, :only => [:show, :edit]
  
  def index
    @jivepages = Jivepage.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jivepages }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jivepage }
    end
  end

  def edit
    return unless editable_by_current_user
    # @edit_session = EditSession.for_page_and_user(@jivepage, current_owner)
  end

  def new
  end
  
  def create
    begin
      @jivepage = jivepage_scope.create_and_setup(params[:jivepage])
      respond_to do |format|
        flash[:notice] = 'Page created'
        format.html { redirect_to(edit_jivepage_path(@jivepage)) }
        format.xml  { render :xml => @jivepage, :status => :created, :location => @jivepage }
      end
    rescue
      @jivepage = Jivepage.new
      @jivepage.errors.add_to_base($!)
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @jivepage.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    return unless editable_by_current_user
    
    respond_to do |format|
      if @jivepage.update_attributes(params[:jivepage])
        flash[:notice] = 'Page saved'
        format.html { redirect_to(@jivepage) }
        format.xml  { head :ok }
        format.js {
          render :update do |page|
            page.call "Jivepage.setup", @jivepage.to_json, true
          end
        }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jivepage.errors, :status => :unprocessable_entity }
        format.js {
          render :update do |page|
            page.alert("Sorry, #{@jivepage.errors.full_messages}")
          end
        }
      end
    end
  end

  def destroy
    return unless editable_by_current_user
    @jivepage.destroy

    respond_to do |format|
      format.html { redirect_to(jivepages_url) }
      format.xml  { head :ok }
    end
  end
  
  
  protected
    #
    #
    #
    def find_jivepage
      begin
        @jivepage = Jivepage.find(params[:id])
      rescue
        flash[:notice] = "Unable to find that page."
        return false
      end
    end
    
    #
    #
    #
    def editable_by_current_user
      if @jivepage.editable_by?(current_owner)
        return true
      else
        flash[:error] = "Sorry, you're not allowed to change this page."
        redirect_to @jivepage
        return false
      end
    end
    
    #
    #
    #
    def load_box_classes
      # Box.subclasses
    end

    #
    #
    #
    def append_box_view_paths
      @jivepage.boxes.each do |box|
        self.append_view_path(box.plugin_view_path)
      end
    end
    
    
    #
    #
    #
    def current_owner
      Jivepage.uses_users? ? current_user : Jivepage
    end

    #
    #
    #
    def jivepage_scope
      Jivepage.uses_users? ? current_owner.jivepages : Jivepage
    end
end
