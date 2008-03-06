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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @me }
    end
  end

  # GET /mes/1/edit
  def edit
    @me = Me.find(params[:id])
  end

  # POST /mes
  # POST /mes.xml
  def create
    @me = Me.new(params[:me])

    respond_to do |format|
      if @me.save
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

    respond_to do |format|
      if @me.update_attributes(params[:me])
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
