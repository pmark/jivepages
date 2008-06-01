class EditSessionsController < ApplicationController
  # GET /edit_sessions
  # GET /edit_sessions.xml
  def index
    @edit_sessions = EditSession.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @edit_sessions }
    end
  end

  # GET /edit_sessions/1
  # GET /edit_sessions/1.xml
  def show
    @edit_session = EditSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @edit_session }
    end
  end

  # GET /edit_sessions/new
  # GET /edit_sessions/new.xml
  def new
    @edit_session = EditSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @edit_session }
    end
  end

  # GET /edit_sessions/1/edit
  def edit
    @edit_session = EditSession.find(params[:id])
  end

  # POST /edit_sessions
  # POST /edit_sessions.xml
  def create
    @edit_session = EditSession.new(params[:edit_session])

    respond_to do |format|
      if @edit_session.save
        flash[:notice] = 'EditSession was successfully created.'
        format.html { redirect_to(@edit_session) }
        format.xml  { render :xml => @edit_session, :status => :created, :location => @edit_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @edit_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /edit_sessions/1
  # PUT /edit_sessions/1.xml
  def update
    @edit_session = EditSession.find(params[:id])

    respond_to do |format|
      if @edit_session.update_attributes(params[:edit_session])
        flash[:notice] = 'EditSession was successfully updated.'
        format.html { redirect_to(@edit_session) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @edit_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /edit_sessions/1
  # DELETE /edit_sessions/1.xml
  def destroy
    @edit_session = EditSession.find(params[:id])
    @edit_session.destroy

    respond_to do |format|
      format.html { redirect_to(edit_sessions_url) }
      format.xml  { head :ok }
    end
  end
end
