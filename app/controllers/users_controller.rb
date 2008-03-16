class UsersController < ApplicationController
  layout 'mes'
  skip_before_filter :is_authed, :only => ['new', 'create']

  def show
    @user = User.find(session['user_id'])

    respond_to do |format|
      format.html { redirect_to(subscriptions_path) }# show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(session['user_id'])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        session['user_id'] = @user.id
        format.html { redirect_to(subscriptions_path) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(session['user_id'])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Password changed successfully.'
        format.html { redirect_to(subscriptions_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
