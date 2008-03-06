class MeSectionsController < ApplicationController
  # GET /me_sections
  # GET /me_sections.xml
  def index
    @me_sections = MeSection.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @me_sections }
    end
  end

  # GET /me_sections/1
  # GET /me_sections/1.xml
  def show
    @me_section = MeSection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @me_section }
    end
  end

  # GET /me_sections/new
  # GET /me_sections/new.xml
  def new
    @me_section = MeSection.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @me_section }
    end
  end

  # GET /me_sections/1/edit
  def edit
    @me_section = MeSection.find(params[:id])
  end

  # POST /me_sections
  # POST /me_sections.xml
  def create
    @me_section = MeSection.new(params[:me_section])

    respond_to do |format|
      if @me_section.save
        flash[:notice] = 'MeSection was successfully created.'
        format.html { redirect_to(@me_section) }
        format.xml  { render :xml => @me_section, :status => :created, :location => @me_section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @me_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /me_sections/1
  # PUT /me_sections/1.xml
  def update
    @me_section = MeSection.find(params[:id])

    respond_to do |format|
      if @me_section.update_attributes(params[:me_section])
        flash[:notice] = 'MeSection was successfully updated.'
        format.html { redirect_to(@me_section) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @me_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /me_sections/1
  # DELETE /me_sections/1.xml
  def destroy
    @me_section = MeSection.find(params[:id])
    @me_section.destroy

    respond_to do |format|
      format.html { redirect_to(me_sections_url) }
      format.xml  { head :ok }
    end
  end
end
