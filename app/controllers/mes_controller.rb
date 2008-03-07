class MesController < ApplicationController
  layout 'mes'
  
  # GET /mes
  # GET /mes.xml
  def index
    @mes = Me.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mes }
    end
  end

  # GET /mes/1
  # GET /mes/1.xml
  def show
    @me = Me.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @me }
    end
  end

  # GET /mes/new
  # GET /mes/new.xml
  def new
    @me = Me.new
    @sections = Section.find(:all)
    @section1 = MeSection.new(:section_type=>1)
    @section2 = MeSection.new(:section_type=>2)
    @section3 = MeSection.new(:section_type=>3)
    @section4 = MeSection.new(:section_type=>4)
    @section5 = MeSection.new(:section_type=>5)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @me }
    end
  end

  # GET /mes/1/edit
  def edit
    @me = Me.find(params[:id])
    @sections = Section.find(:all)
    @section1 = @me.section1
    @section2 = @me.section2
    @section3 = @me.section3
    @section4 = @me.section4
    @section5 = @me.section5
  end

  # POST /mes
  # POST /mes.xml
  def create
    @me = Me.new(params[:me])
    @me.user_id = session['user_id']
    @me.subscribe_token = Me.generate_token
    @me.section1 = MeSection.create(params[:section1])
    @me.section2 = MeSection.create(params[:section2])
    @me.section3 = MeSection.create(params[:section3])
    @me.section4 = MeSection.create(params[:section4])
    @me.section5 = MeSection.create(params[:section5])

    respond_to do |format|
      if @me.save
        Subscription.create(:me_id=>@me.id,:user_id=>session['user_id'],:pos_x=>0,:pos_y=>0,:subscription_token=>@me.subscribe_token)
        flash[:notice] = 'Me was successfully created.'
        format.html { redirect_to(@me) }
        format.xml  { render :xml => @me, :status => :created, :location => @me }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @me.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mes/1
  # PUT /mes/1.xml
  def update
    @me = Me.find(params[:id])
    if params[:reset_token]
      @me.subscribe_token = Me.generate_token
      @me.save!
    end

    respond_to do |format|
      if @me.update_attributes(params[:me])
        @me.section1.update_attributes!(params[:section1])
        @me.section2.update_attributes!(params[:section2])
        @me.section3.update_attributes!(params[:section3])
        @me.section4.update_attributes!(params[:section4])
        @me.section5.update_attributes!(params[:section5])
        flash[:notice] = 'Me was successfully updated.'
        format.html { redirect_to(@me) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @me.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mes/1
  # DELETE /mes/1.xml
  def destroy
    @me = Me.find(params[:id])
    @me.destroy

    respond_to do |format|
      format.html { redirect_to(mes_url) }
      format.xml  { head :ok }
    end
  end

end
