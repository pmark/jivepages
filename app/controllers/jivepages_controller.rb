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
  
  # Automatically create a site if none is given.
  # Anonymous user owns all pages if there's no logged in user.
  def create
    begin
      @user = current_owner      
      begin
        site_id = params[:jivepage][:site_id]
        raise "Create a site" if site_id.blank?
        site = Site.find(site_id, :conditions => {:user_id => @user.id})
      rescue
        begin
          logger.debug "\n\nCreating site with user_id: #{@user.id}\n\n"
          site = Site.new
          site.user = @user
          site.save!
        rescue
          logger.debug "\n\nFAIL! #{$!}\n\n"
          @jivepage = Jivepage.new
          @jivepage.errors.add_to_base("Unable to create site: #{$!}, user: #{@user.inspect}")
          flash[:notice] = 'Unable to create site'
          respond_to do |format|
            format.html { render :action => "new" }
            format.xml  { render :xml => @jivepage.errors, :status => :unprocessable_entity }
          end
          return
        end
      end
      
      @jivepage = site.jivepages.create_and_setup(params[:jivepage].merge(
          :user => @user, :site => site))
          
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
    def append_box_view_paths
      @jivepage.boxes.each do |box|
        self.append_view_path(box.plugin_view_path)
      end
    end    
    
    #
    #
    #
    def current_owner
      current_user || Jivepage.anonymous_user
    end

end
