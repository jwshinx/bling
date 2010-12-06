class FashionsController < ApplicationController
  # GET /fashions
  # GET /fashions.xml
  def index
    logger.debug "=====> FC.index 1"
    @fashions = Fashion.all
    #@fashion = Fashion.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fashions }
    end
  end

  # GET /fashions/1
  # GET /fashions/1.xml
  def show
    @fashion = Fashion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fashion }
    end
  end

  # GET /fashions/new
  # GET /fashions/new.xml
  def new
    @fashions = Fashion.all
    @fashion = Fashion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fashion }
    end
  end

  # GET /fashions/1/edit
  def edit
    @fashion = Fashion.find(params[:id])
  end

  # POST /fashions
  # POST /fashions.xml
  def create
    logger.debug "=====> FC.create 1"
    @fashion = Fashion.new(params[:fashion])
    @fashions = Fashion.all
    logger.debug "=====> FC.create 1.1 #{@fashions.count}"

    respond_to do |format|
      if @fashion.save
        @fashions = Fashion.all
        logger.debug "=====> FC.create 1.1 #{@fashions.count}"
        logger.debug "=====> FC.create 2"
        flash[:notice] = 'Fashion was successfully created.'
        #format.html { redirect_to(@fashion) }
        format.html { redirect_to(fashions_url) }
        format.xml  { render :xml => @fashion, :status => :created, :location => @fashion }
        format.js
      else
        logger.debug "=====> FC.create 3"
        #format.html { render :action => "new" }
        format.html { redirect_to(fashions_url) }
        format.xml  { render :xml => @fashion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fashions/1
  # PUT /fashions/1.xml
  def update
    @fashion = Fashion.find(params[:id])

    respond_to do |format|
      if @fashion.update_attributes(params[:fashion])
        flash[:notice] = 'Fashion was successfully updated.'
        format.html { redirect_to(@fashion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fashion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fashions/1
  # DELETE /fashions/1.xml
  def destroy
    @fashion = Fashion.find(params[:id])
    @fashion.destroy

    respond_to do |format|
      #format.html { redirect_to(fashions_url) }
      format.html { redirect_to(new_fashion_path) }
      format.xml  { head :ok }
    end
  end
end
