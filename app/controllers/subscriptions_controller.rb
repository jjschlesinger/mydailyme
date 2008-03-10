class SubscriptionsController < ApplicationController
  layout 'mes'
  skip_before_filter :is_authed, :only => ['show','index']
  before_filter :authenticate, :only => ['show', 'index']
  
  # GET /subscriptions
  # GET /subscriptions.xml
  def index
    respond_to do |format|
      format.html do # index.html.erb
         @subscriptions_col1 = Subscription.find(:all, :conditions=>['user_id = ? and pos_x = 0',session['user_id']])
         @subscriptions_col2 = Subscription.find(:all, :conditions=>['user_id = ? and pos_x = 1',session['user_id']])
         @subscriptions_col3 = Subscription.find(:all, :conditions=>['user_id = ? and pos_x = 2',session['user_id']])
      end
      format.xml  do
        @subscriptions = Subscription.find(:all, :conditions=>['user_id = ?',session['user_id']])
        render :xml => @subscriptions
      end
      format.rss  do
        @subscriptions = Subscription.find(:all, :conditions=>['user_id = ?',session['user_id']])
        render :layout => false # uses index.rss.builder
      end
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.xml
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subscription }
      format.rss  { render :layout => false } # uses show.rss.builder
    end
  end

 # GET /mes/1/activate/dcf45783hdg3234jd
  def new
    @me = Me.find(params[:id])
    @is_valid = @me.validate_auth(User.find(session['user_id']).login, params[:auth])
    
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.xml
  def create
    @me = Me.find_by_subscribe_token(params[:subscription][:subscription_token])
    if @me.validate_auth(User.find(session['user_id']).login, params[:auth])
      @subscription = Subscription.new(params[:subscription])
      @subscription.collapsed = false
  
      respond_to do |format|
        if @subscription.save
          flash[:notice] = 'Subscription was successfully created.'
          format.html { redirect_to(@subscription) }
          format.xml  { render :xml => @subscription, :status => :created, :location => @subscription }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @subscription.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = 'You are not authorized to subscribe to this Me'
      respond_to do |format|
        format.html { redirect_to(subscriptions_path) }
        format.xml  { render :xml => "invalid auth", :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.xml
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        flash[:notice] = 'Subscription was successfully updated.'
        format.html { redirect_to(@subscription) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.xml
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to(subscriptions_url) }
      format.xml  { head :ok }
    end
  end
  
  def sort_my_me
  if request.xhr?

    @subscription = Subscription.find(params[:id])
     
      if !@subscription.nil?  
        @subscription.pos_x = 1
        @subscription.save()
 
        @subscriptions_col1 = Subscription.find(:all, :conditions=>['user_id = ? and pos_x = 0',session['user_id']])
        render :partial => 'col1'
        #render :text => params[:id].to_s
      else
        render :text => 'fuck'
      end
  end
  end
  
  def sort 
    @subscription = Subscription.find(params[:id]) 
    @subscription.subscriptions.each do |subscription| 
      subscription.pos_y = params['position_y'].index(subscription.id.to_s) 
      subscription.save 
    end 
  end 
  
protected
  def authenticate
    respond_to do |format|
      format.xml do
        authenticate_or_request_with_http_basic('Project Me') do |username, password|
          session['user_id'] = User.authenticate(username, password).id
          if session['user_id'].nil?
            false
          else
            true
          end
        end
      end
      format.rss do
        authenticate_or_request_with_http_basic('Project Me') do |username, password|
          session['user_id'] = User.authenticate(username, password).id
          if session['user_id'].nil?
            false
          else
            true
          end
        end
      end      
      format.html { is_authed }
    end
  end

end
