class SubscriptionsController < ApplicationController
  layout 'mes'
  skip_before_filter :is_authed, :only => ['show','index']
  before_filter :authenticate, :only => ['index']
  
  # GET /subscriptions
  # GET /subscriptions.xml
  def index
    respond_to do |format|
      format.html do # index.html.erb
         @subscriptions_col1 = Subscription.find(:all, :conditions=>['user_id = ? and pos_x = 0',session['user_id']], :order => "pos_x, pos_y")
         @subscriptions_col2 = Subscription.find(:all, :conditions=>['user_id = ? and pos_x = 1',session['user_id']], :order => "pos_x, pos_y")
         @subscriptions_col3 = Subscription.find(:all, :conditions=>['user_id = ? and pos_x = 2',session['user_id']], :order => "pos_x, pos_y")
      end
      format.xml  do
        @subscriptions = Subscription.find(:all, :conditions=>['subscriptions.user_id = ? and subscriptions.me_id is not null',session['user_id']], :include => 'me', :order => 'mes.updated_at DESC')
        render :xml => @subscriptions
      end
      format.rss  do
        @subscriptions = Subscription.find(:all, :conditions=>['subscriptions.user_id = ? and subscriptions.me_id is not null',session['user_id']], :include => 'me', :order => 'mes.updated_at DESC')
        @lastUpdated =  Subscription.find(:first, :conditions=>['subscriptions.user_id = ?', session['user_id']], :include => 'me', :order => 'mes.updated_at DESC')
        render :layout => false # uses index.rss.builder
      end
      format.js do
        @subscriptions = Subscription.find(:all, :conditions=>['subscriptions.user_id = ? and subscriptions.me_id is not null',session['user_id']], :include => 'me', :order => 'mes.updated_at DESC')
        render :json => @subscriptions.to_json(:include => :me)
      end
    end
  end
  # GET /subscriptions/1
  # GET /subscriptions/1.xml
  def show
    

    respond_to do |format|
      format.html { redirect_to(subscriptions_path) }
      format.xml  {
        u = User.authenticate(params[:login], params[:password])
        if u.nil?
          render :nothing => true, :status => 403
          return
        end
        @subscription = Subscription.find(params[:id], :conditions => "user_id = #{u.id}")
        render :xml => @subscription
        }
      format.rss  {
        u = User.authenticate(params[:login], params[:password])
        if u.nil?
          render :nothing => true, :status => 403
          return
        end
        @subscription = Subscription.find(params[:id], :conditions => "user_id = #{u.id}")
        render :layout => false
        } # uses show.rss.builder
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
      breakpoint
      @subscription = Subscription.new(params[:subscription])
      @subscription.collapsed = false
      @subscription.me = @me
      @subscription.pos_x = 0;
      @subscription.pos_y =  Subscription.find_last_y_pos(session['user_id']) + 1;
      
      respond_to do |format|
        if @subscription.save
          flash[:notice] = 'Subscription was successfully created.'
          format.html { redirect_to(subscriptions_path) }
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
  
  def update_position
      params.each_key {|key|
      if key.include?('leftcontent')
        params[key].each_with_index do |id, position|
          @subscription = Subscription.find(id)
            if !@subscription.nil?
            @subscription.pos_x = 0
            @subscription.pos_y = position
            @subscription.save()
            
            end
        end 
      end
      if key.include?('centercontent')
        params[key].each_with_index do |id, position|
          @subscription = Subscription.find(id)
            if !@subscription.nil?
            @subscription.pos_x = 1
            @subscription.pos_y = position
            @subscription.save()
            
            end
        end 
      end
      
      if key.include?('rightcontent')
        params[key].each_with_index do |id, position|
          @subscription = Subscription.find(id)
            if !@subscription.nil?
            @subscription.pos_x = 2
            @subscription.pos_y = position
            @subscription.save()
            
            end
        end 
      end
      }
      render:nothing => true
  end
  
  def is_collapsed
    @subscription = Subscription.find(params[:id])
    @subscription.collapsed = !@subscription.collapsed
    @subscription.save() 
  end 
  
protected
  def authenticate
    breakpoint
    case request.format
    when Mime::XML, Mime::ATOM, Mime::RSS
      authenticate_or_request_with_http_basic('Project Me') do |username, password|
        session['user_id'] = User.authenticate(username, password).id
        breakpoint
        if session['user_id'].nil?
          false
        else
          true
        end
      end
    else
      is_authed
    end
  end

end
