class ContributorshipsController < ApplicationController
  before_filter :login_required, :only => [:create, :update, :destroy]
  
  # GET /contributorships
  # GET /contributorships.xml
  def index
    @contributorships = Contributorship.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contributorships }
    end
  end

  # GET /contributorships/1
  # GET /contributorships/1.xml
  def show
    @contributorship = Contributorship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contributorship }
    end
  end

  # GET /contributorships/new
  # GET /contributorships/new.xml
  def new
    @contributorship = Contributorship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contributorship }
    end
  end

  # GET /contributorships/1/edit
  def edit
    @contributorship = Contributorship.find(params[:id])
  end

  # POST /contributorships
  # POST /contributorships.xml
  def create
    begin
      jivepage = Jivepage.find(params[:contributorship][:jivepage_id])
      if jivepage
        if jivepage.editable_by?(current_user)
          invitee = if params[:contributorship][:user_id]
            User.find(params[:contributorship][:user_id])
          else
            User.find_by_email(params[:email])
          end
          if invitee
            @contributorship = Contributorship.new(
                :jivepage => jivepage, :user => invitee)
          end
        end
      end

      raise "Couldn't find that member." unless invitee
      raise "Contributor is page owner." if invitee == current_user
      
      @contributorship.save!
      UserMailer.deliver_contribution_invitation(@contributorship)
      flash[:notice] = 'The contributor was invited.'
      respond_to do |format|
        format.html { redirect_to(@contributorship) }
        format.xml  do
          render :xml => @contributorship, :status => :created, :location => @contributorship
        end
        format.js do
          render :update do |page|
            page.insert_html :bottom, "contributor_list", 
            content_tag(:li, h(@contributorship.user.email))
            page.visual_effect :highlight, "contributor_list"
          end
        end
      end
    rescue
      logger.error "ERROR adding contributor: #{$!}"
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @contributorship.errors, :status => :unprocessable_entity }
        format.js { 
          render :update do |page|
            page.alert("Sorry, there was a problem adding this contributor: #{$!}")
          end
        }        
      end
    end
  end

  # PUT /contributorships/1
  # PUT /contributorships/1.xml
  def update
    @contributorship = Contributorship.find(params[:id])

    respond_to do |format|
      if @contributorship.update_attributes(params[:contributorship])
        flash[:notice] = 'Contributorship was successfully updated.'
        format.html { redirect_to(@contributorship) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contributorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contributorships/1
  # DELETE /contributorships/1.xml
  def destroy
    @contributorship = Contributorship.find(params[:id])
    @contributorship.destroy

    respond_to do |format|
      format.html { redirect_to(contributorships_url) }
      format.xml  { head :ok }
    end
  end
end
